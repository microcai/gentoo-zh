# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit gnome2-utils

DESCRIPTION="A download manager"
HOMEPAGE="http://www.flashget.com/cn/product_Linux.html"
SRC_URI="http://bbs.flashget.com/download/${P}-0_cn.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	amd64? (
		app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-gtklibs )
	x86? (
		dev-libs/expat
		dev-libs/glib:2
		x11-libs/cairo
		x11-libs/gtk+:2 )"

RESTRICT="primaryuri"

QA_PRESTRIPPED="/opt/flashget/flashget"

src_prepare() {
	sed -b -i -e 's|libexpat\.so\.0|libexpat\.so\.1|g' ${PN}
	sed -i -e 's|/.*/||g' ${PN}.desktop
}

src_install() {
	exeinto /opt/${PN}
	doexe ${PN} || die

	dodir /opt/bin
	dosym /opt/{${PN}/${PN},bin}

	insinto /usr/share/applications
	doins ${PN}.desktop
	insinto /usr/share/icons/hicolor/48x48/apps/
	doins ${PN}.png

	dodoc README
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
