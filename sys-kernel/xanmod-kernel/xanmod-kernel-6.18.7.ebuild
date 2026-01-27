# Copyright 2020-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LLVM_COMPAT=(19 20)

inherit kernel-build toolchain-funcs llvm-r1

MY_P=linux-${PV%.*}
#Note: to bump xanmod, check GENPATCHES_P in sys-kernel/gentoo-kernel
PATCHSET=linux-gentoo-patches-6.18.2
GENPATCHES_P=genpatches-${PV%.*}-$((${PV##*.}))
XV="1"

DESCRIPTION="XanMod lts kernel built with Gentoo patches and cjktty"
HOMEPAGE="
	https://www.kernel.org/
	https://xanmod.org/
"
SRC_URI+="
	https://cdn.kernel.org/pub/linux/kernel/v$(ver_cut 1).x/${MY_P}.tar.xz
	https://dev.gentoo.org/~mgorny/dist/linux/${PATCHSET}.tar.xz
	https://phoenixnap.dl.sourceforge.net/project/xanmod/releases/main/${PV}-xanmod1/patch-${PV}-xanmod1.xz"
S=${WORKDIR}/${MY_P}

LICENSE="GPL-2"
KEYWORDS="~amd64"
IUSE="clang debug"

BDEPEND="
	clang? (
		$(llvm_gen_dep '
			llvm-core/llvm:${LLVM_SLOT}
			llvm-core/clang:${LLVM_SLOT}
			llvm-core/lld:${LLVM_SLOT}
		')
	)
"

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
	if use clang && ! tc-is-clang; then
		export LLVM_IAS=1
		export LLVM=1
		export CC=clang
		export LD=ld.lld
		export AR=llvm-ar
		export NM=llvm-nm
		export OBJCOPY=llvm-objcopy
		export OBJDUMP=llvm-objdump
		export READELF=llvm-readelf
		export STRIP=llvm-strip
	else
		tc-export CXX CC
	fi

}

src_prepare() {
	# delete failed patches
	rm "${WORKDIR}/${PATCHSET}/0011-BMQ-BitMap-Queue-Scheduler.-A-new-CPU-scheduler-deve.patch"
	rm "${WORKDIR}/${PATCHSET}/0012-Set-defaults-for-BMQ.-Add-archs-as-people-test-defau.patch"
	rm "${WORKDIR}/${PATCHSET}/1710_disable_sse4a.patch'"
	rm "${WORKDIR}/${PATCHSET}/2701-drm-amdgpu-don-t-attach-the-tlb-fence-for-SI.patch"

	local PATCHES=(
		# xanmod patches
		"${WORKDIR}"/patch-${PV}-xanmod${XV}
		# genpatches
		"${WORKDIR}/${PATCHSET}"/*.patch
	)
	default

	# prepare the default config
	case ${ARCH} in
	amd64)
		cp "${S}/CONFIGS/x86_64/config" .config || die
		XV="${XV}-x64v3"
		;;
	*)
		die "Unsupported arch ${ARCH}"
		;;
	esac

	echo "CONFIG_MODPROBE_PATH=\"/sbin/modprobe\"" >"${T}"/modprobe.config || die

	local merge_configs=(
		"${T}"/modprobe.config
	)

	kernel-build_merge_configs "${merge_configs[@]}"
	# delete localversion
	rm "${S}/localversion" || die
}
