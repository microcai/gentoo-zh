# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="at32 workbench is a GUI tool for AT32 MCU startup code generation"
HOMEPAGE="https://www.arterytek.com/cn/support/tools.jsp"
SRC_URI="https://www.arterytek.com/download/AT32%20Workbench/AT32_Work_Bench_Linux-x86_64_V${PV}.zip"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror"

DEPEND="
	dev-qt/qtxml:5
	dev-qt/qtwidgets:5
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
"

RDEPEND="${DEPEND}"
BDEPEND="app-arch/unzip"

inherit unpacker

S="${WORKDIR}"

src_unpack(){
	unpack ${A}
	unpack ${WORKDIR}/AT32_Work_Bench_Linux-x86_64_V${PV}.deb
}

src_install(){
	tar -xvf ${WORKDIR}/data.tar.xz -C "$D"
	pushd ${D}/usr/local/AT32_Work_Bench
	rm libQt5*
	rm platforms -rf
}
