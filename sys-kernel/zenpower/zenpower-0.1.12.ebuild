# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-info linux-mod

DESCRIPTION="Linux kernel driver for reading sensors of AMD Zen family CPUs"
HOMEPAGE="https://github.com/ocerman/zenpower"
SRC_URI="https://github.com/ocerman/zenpower/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

CONFIG_CHECK="HWMON PCI AMD_NB"

BUILD_TARGETS="modules"
MODULE_NAMES="zenpower(kernel/drivers/hwmon:${S})"
