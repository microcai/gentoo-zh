# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

DESCRIPTION="at32 workbench is a GUI tool for AT32 MCU startup code generation"
HOMEPAGE="https://www.arterytek.com/cn/support/tools.jsp"
SRC_URI="https://www.arterytek.com/download/AT32%20Workbench/AT32_Work_Bench_Linux-x86_64_V${PV}.zip"
S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror bindist"

BDEPEND="app-arch/unzip"

src_unpack(){
	unpack "${A}"
	unpack "${WORKDIR}"/AT32_Work_Bench_Linux-x86_64_V"${PV}".deb
}

src_install(){
	tar -xvf "${WORKDIR}"/data.tar.xz -C "${D}"
}
