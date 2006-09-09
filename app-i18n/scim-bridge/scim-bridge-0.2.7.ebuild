# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit eutils

DESCRIPTION="Scim-bridge is yet another IM client of SCIM"
HOMEPAGE="http://www.scim-im.org/projects/scim_bridge"
SRC_URI="mirror://sourceforge/scim/${P}.tar.gz
	http://freedesktop.org/~scim/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug"

RDEPEND=">=app-i18n/scim-1.4.2
	virtual/libintl"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig"

RESTRICT="primaryuri"

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_compile() {
	econf \
		$(use_enable debug scim-debug) \
		--disable-static \
		--enable-shared \
		--disable-dependency-tracking || die "econf failed"
	emake || die "make failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog README NEWS TODO
}

pkg_postinst() {
	einfo
	einfo "After you emerged ${PN}, use right click to switch immodules for GTK2."
	einfo "If you would like to use ${PN} as default instead of XIM, set"
	einfo "	% export GTK_IM_MODULE=scim-bridge"
	einfo
}
