# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop

DESCRIPTION="嘉立创EDA - 高效的国产PCB设计工具"
HOMEPAGE="https://lceda.cn/"
SRC_URI="https://image.lceda.cn/files/${PN}-linux-x64-${PV}.zip"

RESTRICT="mirror"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="app-arch/unzip"

S="${WORKDIR}/lceda-linux-x64"
QA_PREBUILT="
	/opt/lceda/swiftshader/libEGL.so
	/opt/lceda/swiftshader/libGLESv2.so
	/opt/lceda/lceda
	/opt/lceda/libEGL.so
	/opt/lceda/libffmpeg.so
	/opt/lceda/libGLESv2.so
"

src_install(){
	insinto /opt/lceda
	doins -r .
	fperms 0755 /opt/lceda/lceda
	newmenu LCEDA.dkt LCEDA.desktop
}
