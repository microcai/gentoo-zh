# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $

inherit libtool

DESCRIPTION="fcitx ported to scim platform"
HOMEPAGE="http://www.fcitx.org/"
SRC_URI="mirror://sourceforge/scim/${PN}.${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

RESTRICT="primaryuri"

DEPEND="|| ( >=app-i18n/scim-1.2 >=app-i18n/scim-cvs-1.2 )
	virtual/libintl"
DEPEND="${DEPEND}
	sys-devel/gettext
	dev-util/pkgconfig"

MAKEOPTS=""
S="${WORKDIR}/fcitx/"

src_unpack() {
	unpack ${A}

	elibtoolize
}

src_compile() {
	econf \
		--disable-static \
		--disable-dependency-tracking || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

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
