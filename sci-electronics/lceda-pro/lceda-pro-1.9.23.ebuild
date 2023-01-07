# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop

DESCRIPTION="嘉立创EDA(专业版) - 高效的国产PCB设计工具"
HOMEPAGE="https://lceda.cn/"

RESTRICT="mirror"
LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~loong"
SRC_URI="
	amd64?	( https://image.lceda.cn/files/${PN}-linux-x64-${PV}.zip )
	arm64?	( https://image.lceda.cn/files/${PN}-linux-arm64-${PV}.zip )
	loong?	( https://image.lceda.cn/files/${PN}-linux-loong64-${PV}.zip )
"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="app-arch/unzip"

S="${WORKDIR}/lceda-pro"

QA_PREBUILT="
	/opt/lceda-pro/chrome-sandbox
	/opt/lceda-pro/chrome_crashpad_handler
	/opt/lceda-pro/libEGL.so
	/opt/lceda-pro/libffmpeg.so
	/opt/lceda-pro/resources/app/node_modules/sqlite3/lib/binding/napi-v3-linux-x64/node_sqlite3.node
	/opt/lceda-pro/lceda-pro
	/opt/lceda-pro/libvk_swiftshader.so
	/opt/lceda-pro/libGLESv2.so
	/opt/lceda-pro/libvulkan.so.1
"

src_install(){
	insinto /opt/lceda-pro
	doins -r .
	fperms 0755 /opt/lceda-pro/lceda-pro
	newmenu lceda-pro.dkt LCEDA-pro.desktop
}
