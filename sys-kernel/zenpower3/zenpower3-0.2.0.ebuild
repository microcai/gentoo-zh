# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1

DESCRIPTION="Linux kernel driver for reading sensors of AMD Zen family CPUs"
HOMEPAGE="https://git.exozy.me/a/zenpower3"

if [[ ${PV} == 9999 ]] ; then
	EGIT_REPO_URI="https://git.exozy.me/a/zenpower3.git"
	inherit git-r3
	unset MODULES_KERNEL_MAX
else
	SRC_URI="https://git.exozy.me/a/zenpower3/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"

CONFIG_CHECK="HWMON PCI AMD_NB"
MODULES_KERNEL_MIN=5.3.4

src_compile() {
	local modlist=(
		zenpower
	)
	local modargs=( TARGET="${KV_FULL}" KERNEL_BUILD="${KV_OUT_DIR}" )
	linux-mod-r1_src_compile
}

pkg_postinst() {
	linux-mod-r1_pkg_postinst

	elog ""
	elog "To use zenpower, please disable k10temp first"
	elog "see https://git.exozy.me/a/zenpower3#module-activation"
}
