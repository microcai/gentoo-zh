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
	amd64?	( https://image.lceda.cn/files/lceda-pro-linux-x64-${PV}.zip )
	arm64?	( https://image.lceda.cn/files/lceda-pro-linux-arm64-${PV}.zip )
	loong?	( https://image.lceda.cn/files/lceda-pro-linux-loong64-${PV}.zip )
"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="app-arch/unzip"

S="${WORKDIR}/lceda-pro"

src_install(){
	insinto /opt/lceda-pro
	doins -r .
	fperms 0755 /opt/lceda-pro/lceda-pro
	newmenu lceda-pro.dkt LCEDA-pro.desktop
}
