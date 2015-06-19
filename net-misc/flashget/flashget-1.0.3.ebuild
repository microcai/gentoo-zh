# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils gnome2-utils

DESCRIPTION="A download manager"
HOMEPAGE="http://www.flashget.com/cn/product_Linux.html"
SRC_URI="http://bbs.flashget.com/download/${P}-0_cn.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
		dev-libs/expat
		dev-libs/glib:2[abi_x86_abi]
		x11-libs/cairo[abi_x86_abi]
		x11-libs/gtk+:2[abi_x86_abi]
"

RESTRICT="primaryuri"

QA_PRESTRIPPED="/opt/flashget/flashget"

pkg_nofetch() {
	eerror "如果下载地址失效,请尝试在 http://pan.baidu.com/s/1sjnRDLj 下载."
}
src_prepare() {
	# fixed lib name mismatch
	sed -b -i -e 's|libexpat\.so\.0|libexpat\.so\.1|g' ${PN}
	# fixed path
	sed -i -e 's|/.*/||g' ${PN}.desktop
}

src_install() {
	exeinto /opt/${PN}
	doexe ${PN} || die
	dodir /opt/bin
	dosym /opt/{${PN}/${PN},bin}

	domenu ${PN}.desktop
	doicon ${PN}.png

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
