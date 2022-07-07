# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop

DESCRIPTION="DDraceNetwork, a cooperative racing mod of Teeworlds"
HOMEPAGE="https://ddnet.tw/ https://github.com/ddnet/ddnet"
SRC_URI="https://ddnet.tw/downloads/${P}-linux_x86_64.tar.xz -> ${P}.tar.xz"

LICENSE="CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	media-libs/vulkan-loader
"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"

BASENAME="${P}-linux_x86_64"

src_install(){
	insinto "/opt"
	doins -r "${BASENAME}"
	make_desktop_entry "/opt/${BASENAME}/${PN}" ${PN} "/opt/${BASENAME}/data/gui_logo.png" "Game"
	fperms 0755 /opt/${BASENAME}/{DDNet,DDNet-Server,config_retrieve,config_store,dilate,map_convert_07,map_diff,map_extract}
}

pkg_postinst(){
	ewarn "To support fcitx pinyin input, please recompile your libsdl2 with fcitx enabled."
}
