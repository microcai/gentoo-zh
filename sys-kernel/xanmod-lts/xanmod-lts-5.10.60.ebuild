# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# Define what default functions to run
ETYPE="sources"

# No 'experimental' USE flag provided, but we still want to use genpatches
K_EXP_GENPATCHES_NOUSE="1"

# Just get basic genpatches, -xanmod patch set already includes main updates
K_GENPATCHES_VER="1"

# -xanmod-lts already sets EXTRAVERSION to kernel Makefile
K_NOSETEXTRAVERSION="1"

# Not supported by the Gentoo security team
K_SECURITY_UNSUPPORTED="1"

# We want the very basic patches from gentoo-sources, experimental patch is
# already included in xanmod-lts
K_WANT_GENPATCHES="base extras"

inherit kernel-2 kernel-build
detect_version

MY_P=linux-${PV%.*}
GENPATCHES_P=genpatches-${PV%.*}-$(( ${PV##*.} + 6 ))
CONFIG_VER=5.10.12
GENTOO_CONFIG_VER=5.10.42

DESCRIPTION="xanmod-lts Linux kernel built with Gentoo patches"
HOMEPAGE="https://xanmod.org/"
SRC_URI="
	${KERNEL_BASE_URI}/${MY_P}.tar.xz
	${GENPATCHES_URI}
	https://github.com/xanmod/linux/releases/download/${PV}-xanmod1/patch-${PV}-xanmod1.xz
	https://github.com/mgorny/gentoo-kernel-config/archive/v${GENTOO_CONFIG_VER}.tar.gz
		-> gentoo-kernel-config-${GENTOO_CONFIG_VER}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64"

PDEPEND="
	>=virtual/dist-kernel-${PV}"

QA_FLAGS_IGNORED="usr/src/linux-.*/scripts/gcc-plugins/.*.so"

src_unpack() {
	UNIPATCH_LIST_DEFAULT+="
	${DISTDIR}/patch-${PV}-xanmod1.xz"
	kernel-2_src_unpack "$@"
	unpack "gentoo-kernel-config-${GENTOO_CONFIG_VER}.tar.gz"
}

src_prepare() {
	default

	# prepare the default config
	case ${ARCH} in
		amd64)
			cp "${S}/CONFIGS/xanmod/gcc/config" .config || die
			;;
		*)
			die "Unsupported arch ${ARCH}"
			;;
	esac

	local myversion="-gentoo-xanmod-lts-dist"
	echo "CONFIG_LOCALVERSION=\"${myversion}\"" > "${T}"/version.config || die
	local dist_conf_path="${S}/gentoo-kernel-config-${GENTOO_CONFIG_VER}"

	local merge_configs=(
		"${T}"/version.config
		"${dist_conf_path}"/base.config
	)
	kernel-build_merge_configs "${merge_configs[@]}"
}

pkg_setup() {
	ewarn ""
	ewarn "${PN} is *not* supported by the Gentoo Kernel Project in any way."
	ewarn "If you need support, please contact the maintainer directly."
	ewarn "Do *not* open bugs in Gentoo's bugzilla unless you have issues with"
	ewarn "the ebuilds. Thank you."
	ewarn ""

	kernel-2_pkg_setup
}

pkg_postinst() {
	elog "MICROCODES"
	elog "Use xanmod-lts with microcodes"
	elog "Read https://wiki.gentoo.org/wiki/Intel_microcode"
}
