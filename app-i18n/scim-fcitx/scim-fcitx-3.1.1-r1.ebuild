# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils #libtool

DESCRIPTION="fcitx ported to scim platform"
HOMEPAGE="http://www.fcitx.org/"
SRC_URI="mirror://sourceforge/scim/${PN}.${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

RESTRICT="primaryuri"

RDEPEND="|| ( >=app-i18n/scim-1.2 >=app-i18n/scim-cvs-1.2 )
	virtual/libintl"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	dev-util/pkgconfig"

S=${WORKDIR}/${PN#scim-}
MAKEOPTS="${MAKEOPTS} -j1"

src_prepare() {
	# http://gentoo-china-overlay.googlecode.com/issues/attachment?aid=5755634360147105360&name=scim_fcitx.patch
	epatch "${FILESDIR}"/${PN}-missing-headers.patch
	#elibtoolize
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS THANKS README
}

pkg_postinst() {
	einfo
	einfo "To use SCIM, you should use the following in your user startup scripts"
	einfo "such as .gnomerc or .xinitrc:"
	einfo
	einfo "LANG='your_language' scim -d"
	einfo "export XMODIFIERS=@im=SCIM"
	einfo "export GTK_IM_MODULE=scim"
	einfo "export QT_IM_MODULE=scim"
	einfo
}
