# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="12"
K_SECURITY_UNSUPPORTED="1"
K_NOSETEXTRAVERSION="1"

inherit check-reqs kernel-2 optfeature
detect_version
detect_arch

MY_KV="${KV_MAJOR}.${KV_MINOR}"
AUFS_V="20250210"
GIT_COMMIT_CACHYOS="17a908b99d5f581bc9d2c8d5504b0edc6a745b80"

DESCRIPTION="Full Cachyos sources including the Gentoo patchset for the ${MY_KV} kernel tree"
HOMEPAGE="https://cachyos.org"
CACHYOS_URI="https://raw.githubusercontent.com/CachyOS/kernel-patches/${GIT_COMMIT_CACHYOS}/${MY_KV}"
SRC_URI="
	${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI}
	${CACHYOS_URI}/0004-cachy.patch -> ${P}-0004-cachy.patch
	amd-pstate? ( ${CACHYOS_URI}/0001-amd-pstate.patch -> ${P}-0001-amd-pstate.patch )
	amd-tlb-broadcast? ( ${CACHYOS_URI}/0002-amd-tlb-broadcast.patch -> ${P}-0002-amd-tlb-broadcast.patch )
	bbr3? ( ${CACHYOS_URI}/0003-bbr3.patch -> ${P}-0003-bbr3.patch )
	crypto? ( ${CACHYOS_URI}/0005-crypto.patch -> ${P}-0005-crypto.patch )
	fixes? ( ${CACHYOS_URI}/0006-fixes.patch -> ${P}-0006-fixes.patch )
	itmt-core-ranking? ( ${CACHYOS_URI}/0007-itmt-core-ranking.patch -> ${P}-0007-itmt-core-ranking.patch )
	ntsync? ( ${CACHYOS_URI}/0008-ntsync.patch -> ${P}-0008-ntsync.patch )
	perf-per-core? ( ${CACHYOS_URI}/0009-perf-per-core.patch -> ${P}-0009-perf-per-core.patch )
	pksm? ( ${CACHYOS_URI}/0010-pksm.patch -> ${P}-0010-pksm.patch )
	t2? ( ${CACHYOS_URI}/0011-t2.patch -> ${P}-0011-t2.patch )
	zstd? ( ${CACHYOS_URI}/0012-zstd.patch -> ${P}-0012-zstd.patch )
	bore? ( ${CACHYOS_URI}/sched/0001-bore-cachy.patch -> ${P}-0001-bore-cachy.patch )
	prjc? ( ${CACHYOS_URI}/sched/0001-prjc-cachy.patch -> ${P}-0001-prjc-cachy.patch )
	polly? ( ${CACHYOS_URI}/misc/0001-clang-polly.patch -> ${P}-0001-clang-polly.patch )
	hardened? ( ${CACHYOS_URI}/misc/0001-hardened.patch -> ${P}-0001-hardened.patch )
	rt? ( ${CACHYOS_URI}/misc/0001-rt-i915.patch -> ${P}-0001-rt-i915.patch )
	dkms-clang? ( ${CACHYOS_URI}/misc/dkms-clang.patch -> ${P}-dkms-clang.patch )
	clang-polly? ( ${CACHYOS_URI}/misc/0001-clang-polly.patch -> ${P}-0001-clang-polly.patch )
	aufs? ( ${CACHYOS_URI}/misc/0001-aufs-${MY_KV}-merge-v${AUFS_V}.patch
		-> ${P}-0001-aufs-${MY_KV}-merge-v${AUFS_V}.patch )
	deckify? (
		${CACHYOS_URI}/misc/0001-acpi-call.patch -> ${P}-0001-acpi-call.patch
		${CACHYOS_URI}/misc/0001-handheld.patch -> ${P}-0001-handheld.patch
	)
"
KEYWORDS="~amd64"
IUSE="amd-pstate amd-tlb-broadcast bbr3 +crypto +fixes itmt-core-ranking ntsync perf-per-core pksm t2 +zstd +bore prjc polly hardened rt dkms-clang clang-polly aufs deckify"
REQUIRED_USE="?? ( bore prjc )"

pkg_pretend() {
	CHECKREQS_DISK_BUILD="4G"
	check-reqs_pkg_pretend
}

src_unpack() {
	use fixes && UNIPATCH_EXCLUDE="1740_x86-insn-decoder-test-allow-longer-symbol-names.patch"
	kernel-2_src_unpack
}

src_prepare() {
	use amd-pstate && eapply "${DISTDIR}/${P}-0001-amd-pstate.patch"
	use amd-tlb-broadcast && eapply "${DISTDIR}/${P}-0002-amd-tlb-broadcast.patch"
	use bbr3 && eapply "${DISTDIR}/${P}-0003-bbr3.patch"
	eapply "${DISTDIR}/${P}-0004-cachy.patch"
	use crypto && eapply "${DISTDIR}/${P}-0005-crypto.patch"
	use fixes && eapply "${DISTDIR}/${P}-0006-fixes.patch"
	use itmt-core-ranking && eapply "${DISTDIR}/${P}-0007-itmt-core-ranking.patch"
	use ntsync && eapply "${DISTDIR}/${P}-0008-ntsync.patch"
	use perf-per-core && eapply "${DISTDIR}/${P}-0009-perf-per-core.patch"
	use pksm && eapply "${DISTDIR}/${P}-0010-pksm.patch"
	use t2 && eapply "${DISTDIR}/${P}-0011-t2.patch"
	use zstd && eapply "${DISTDIR}/${P}-0012-zstd.patch"
	use bore && eapply "${DISTDIR}/${P}-0001-bore-cachy.patch"
	use prjc && eapply "${DISTDIR}/${P}-0001-prjc-cachy.patch"
	use polly && eapply "${DISTDIR}/${P}-0001-clang-polly.patch"
	use hardened && eapply "${DISTDIR}/${P}-0001-hardened.patch"
	use rt && eapply "${DISTDIR}/${P}-0001-rt-i915.patch"
	use dkms-clang && eapply "${DISTDIR}/${P}-dkms-clang.patch"
	use clang-polly && eapply "${DISTDIR}/${P}-0001-clang-polly.patch"
	use aufs && eapply "${DISTDIR}/${P}-0001-aufs-${MY_KV}-merge-v${AUFS_V}.patch"

	if use deckify; then
		eapply "${DISTDIR}/${P}-0001-acpi-call.patch"
		eapply "${DISTDIR}/${P}-0001-handheld.patch"
	fi

	kernel-2_src_prepare
	rm "${S}/tools/testing/selftests/tc-testing/action-ebpf"
}

pkg_setup() {
	ewarn
	ewarn "${PN} is *not* supported by the Gentoo Kernel Project in any way."
	ewarn "If you need support, please contact https://github.com/microcai/gentoo-zh and ${HOMEPAGE} directly."
	ewarn "Do *not* open bugs in Gentoo's bugzilla unless you have issues with"
	ewarn "the ebuilds. Thank you."
	ewarn
	kernel-2_pkg_setup
}

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"

	use pksm && optfeature "userspace KSM helper" sys-process/cachyos-ksm-settings sys-process/uksmd
	if use polly && ! has_version llvm-core/clang-runtime[polly]; then
		einfo "You need to enable polly use flag for llvm-core/clang-runtime to build the kernel with polly"
	fi
}

pkg_postrm() {
	kernel-2_pkg_postrm
}
