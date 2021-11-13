# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit kernel-build toolchain-funcs

MY_P=linux-${PV%.*}
GENPATCHES_P=genpatches-${PV%.*}-$((${PV##*.} + 6))
XV="1"
LINUX_CONFIG_VER=5.10.75
LINUX_CONFIG_DIR="${WORKDIR}/linux-config-${LINUX_CONFIG_VER}"

DESCRIPTION="XanMod lts kernel built with Gentoo patches and cjktty"
HOMEPAGE="https://www.kernel.org/"
SRC_URI+=" https://cdn.kernel.org/pub/linux/kernel/v$(ver_cut 1).x/${MY_P}.tar.xz
	https://dev.gentoo.org/~mpagano/dist/genpatches/${GENPATCHES_P}.base.tar.xz
	https://dev.gentoo.org/~mpagano/dist/genpatches/${GENPATCHES_P}.extras.tar.xz
	https://github.com/xanmod/linux/releases/download/${PV}-xanmod${XV}/patch-${PV}-xanmod${XV}.xz
	https://github.com/OriPoin/linux-config/archive/refs/tags/${LINUX_CONFIG_VER}.tar.gz -> linux-config-${LINUX_CONFIG_VER}.tar.gz
	https://raw.githubusercontent.com/zhmars/cjktty-patches/master/v5.x/cjktty-5.10.patch"
S=${WORKDIR}/${MY_P}

LICENSE="GPL-2"
KEYWORDS="amd64"
IUSE="systemd zstd debug hardened cjk"

PDEPEND="
	>=virtual/dist-kernel-${PV}"

QA_FLAGS_IGNORED="usr/src/linux-.*/scripts/gcc-plugins/.*.so"

src_prepare() {
	# delete linux version patches
	rm "${WORKDIR}"/10*.patch || die

	local PATCHES=(
		# genpatches
		"${WORKDIR}"/*.patch
		# xanmod patches
		"${WORKDIR}"/patch-${PV}-xanmod${XV}
	)
	if use cjk; then
		PATCHES+=("${DISTDIR}/cjktty-5.10.patch")
	fi
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

	local myversion="-xanmod${XV}-lts"
	echo "CONFIG_LOCALVERSION=\"${myversion}\"" >"${T}"/version.config || die

	local merge_configs=(
		"${T}"/version.config
		"${LINUX_CONFIG_DIR}"/base.config
	)
	use debug || merge_configs+=(
		"${LINUX_CONFIG_DIR}"/no-debug.config
	)

	if use zstd; then
		merge_configs+=("${LINUX_CONFIG_DIR}"/zstd.config)
	fi
	if use systemd; then
		merge_configs+=("${LINUX_CONFIG_DIR}"/systemd.config)
	fi

	if use hardened; then
		merge_configs+=("${LINUX_CONFIG_DIR}"/hardened-base.config)

		tc-is-gcc && merge_configs+=("${LINUX_CONFIG_DIR}"/hardened-gcc-plugins.config)

		if [[ -f "${LINUX_CONFIG_DIR}/hardened-${ARCH}.config" ]]; then
			merge_configs+=("${LINUX_CONFIG_DIR}/hardened-${ARCH}.config")
		fi
	fi

	kernel-build_merge_configs "${merge_configs[@]}"
	# delete localversion
	rm "${S}/localversion" || die
}
