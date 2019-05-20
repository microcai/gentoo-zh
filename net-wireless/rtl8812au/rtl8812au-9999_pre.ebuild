# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-mod

DESCRIPTION="rtl8812AU rtl8821AU linux kernel driver for AC1200 (801.11ac) Wireless Dual-Band USB Adapter"
HOMEPAGE="https://github.com/abperiasamy/rtl8812AU_8821AU_linux"
SRC_URI="https://github.com/abperiasamy/rtl8812AU_8821AU_linux/archive/master.zip"
LICENSE="GPL-2.0"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

WORKDIR="${WORKDIR}/rtl8812AU_8821AU_linux-master"
S="${WORKDIR}"

#src_configure() {
#	set_arch_to_kernel
#}

pkg_setup() {
	linux-mod_pkg_setup

	BUILD_TARGETS="modules"
	MODULE_NAMES="rtl8812au(kernel/drivers/net/wireless/:${S})"
}

src_compile() {
	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install
}
