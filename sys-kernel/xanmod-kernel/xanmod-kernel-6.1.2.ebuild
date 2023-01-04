# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit kernel-build python-any-r1

MY_P=linux-${PV%.*}
#Note: to bump xanmod, check GENPATCHES_P in sys-kernel/gentoo-kernel
GENPATCHES_P=genpatches-${PV%.*}-$((${PV##*.} + 1))
XV="1"

DESCRIPTION="XanMod lts kernel built with Gentoo patches and cjktty"
HOMEPAGE="https://www.kernel.org/"
SRC_URI+=" https://cdn.kernel.org/pub/linux/kernel/v$(ver_cut 1).x/${MY_P}.tar.xz
	https://dev.gentoo.org/~mpagano/dist/genpatches/${GENPATCHES_P}.base.tar.xz
	https://dev.gentoo.org/~mpagano/dist/genpatches/${GENPATCHES_P}.extras.tar.xz
	https://github.com/xanmod/linux/releases/download/${PV}-xanmod${XV}/patch-${PV}-xanmod${XV}.xz
	https://raw.githubusercontent.com/zhmars/cjktty-patches/master/v6.x/cjktty-${PV%.*}.patch"
S=${WORKDIR}/${MY_P}

LICENSE="GPL-2"
KEYWORDS="~amd64"
IUSE="cjk debug"
SLOT="edge"

PDEPEND="
	>=virtual/dist-kernel-${PV}"

QA_FLAGS_IGNORED="usr/src/linux-.*/scripts/gcc-plugins/.*.so"

pkg_setup() {
	ewarn ""
	ewarn "${PN} is *not* supported by the Gentoo Kernel Project in any way."
	ewarn "You have to configure the kernel by yourself."
	ewarn "Generally emerge this package using default config will fail to boot."
	ewarn "If you need support, please contact the ${HOMEPAGE} or maintainer directly."
	ewarn "Do *not* open bugs in Gentoo's bugzilla unless you have issues with"
	ewarn "the ebuilds. Thank you."
	ewarn ""
	python-any-r1_pkg_setup "$@"
}

src_prepare() {
	# delete linux version patches
	rm "${WORKDIR}"/*${MY_P}*.patch || die

	local PATCHES=(
		# genpatches
		"${WORKDIR}"/*.patch
		# xanmod patches
		"${WORKDIR}"/patch-${PV}-xanmod${XV}
	)
	if use cjk; then
		PATCHES+=("${DISTDIR}/cjktty-${PV%.*}.patch")
	fi
	default

	# prepare the default config
	case ${ARCH} in
	amd64)
		cp "${S}/CONFIGS/xanmod/gcc/config_x86-64-v1" .config || die
		;;
	*)
		die "Unsupported arch ${ARCH}"
		;;
	esac

	local myversion="-xanmod${XV}"
	echo "CONFIG_LOCALVERSION=\"${myversion}\"" >"${T}"/version.config || die
	echo "CONFIG_MODPROBE_PATH=\"/sbin/modprobe\"" >"${T}"/modprobe.config || die

	local merge_configs=(
		"${T}"/version.config
		"${T}"/modprobe.config
	)

	kernel-build_merge_configs "${merge_configs[@]}"
	# delete localversion
	rm "${S}/localversion" || die
}
