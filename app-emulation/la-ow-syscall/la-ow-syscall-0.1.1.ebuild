# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1

MODULES_KERNEL_MIN=6.1

DESCRIPTION="Linux kernel module for compatibility with LoongArch's old-world ABI"
HOMEPAGE="https://github.com/AOSC-Dev/la_ow_syscall"

MY_PN="${PN//-/_}"

case "${PV}" in
9999)
	EGIT_REPO_URI="https://github.com/AOSC-Dev/la_ow_syscall"
	inherit git-r3
	;;
*)
	SRC_URI="https://github.com/AOSC-Dev/la_ow_syscall/releases/download/debian/v${PV}/liblol-dkms_${PV}.tar.xz"
	S="${WORKDIR}/${MY_PN}"
	KEYWORDS="-* ~loong"
	;;
esac

LICENSE="GPL-2"
SLOT="0"
RESTRICT="mirror test"

BDEPEND="app-arch/unzip"

CONFIG_CHECK="
KALLSYMS
KPROBES
"

src_compile() {
	# otherwise the build script uses `uname -r` that will break if the
	# target kernel version differs from the running one
	export KVER="${KV_FULL}"

	local modlist=(
		la_ow_syscall
	)
	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install

	insinto /usr/lib/modules-load.d
	doins "${FILESDIR}/la-ow-syscall.conf"
}

pkg_postinst() {
	linux-mod-r1_pkg_postinst

	elog "Be sure to load the kernel module before running any old-world program:"
	elog
	elog "# modprobe la_ow_syscall"
	elog
	elog "A config file has been installed under /usr/lib/modules-load.d for"
	elog "automatic loading of the compatibility patch on system start-up."
}
