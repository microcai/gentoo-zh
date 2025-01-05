# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="11"
K_SECURITY_UNSUPPORTED="1"
K_NOSETEXTRAVERSION="1"

inherit check-reqs kernel-2
detect_version
detect_arch

MY_P="linux-tkg-${PV}"
MY_KV="${KV_MAJOR}.${KV_MINOR}"
GIT_COMMIT_CACHYOS="cab04f4f528d9c5e8ec93207204f6f8ecd920ead"
GIT_COMMIT_GRAYSKY="8b4675b3a96547b73fa92f87f6a6b3a2e387ac06"
PRJC_REV="0"

DESCRIPTION="Full linux-tkg sources including the Gentoo patchset for the ${MY_KV} kernel tree"
HOMEPAGE="https://github.com/Frogging-Family/linux-tkg"
TKG_URI="https://github.com/Frogging-Family/linux-tkg/archive/refs/tags/v${PV}.tar.gz -> ${MY_P}.tar.gz"
CACHYOS_URI="https://raw.githubusercontent.com/CachyOS/kernel-patches/${GIT_COMMIT_CACHYOS}/${MY_KV}"
SRC_URI="
	${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${TKG_URI}
	graysky? ( https://raw.githubusercontent.com/graysky2/kernel_compiler_patch/${GIT_COMMIT_GRAYSKY}/more-ISA-levels-and-uarches-for-kernel-6.1.79%2B.patch
		-> ${P}-more-ISA-levels-and-uarches-for-kernel-6.1.79+.patch )
	bore? ( ${CACHYOS_URI}/sched/0001-bore.patch -> ${P}-0001-bore.patch )
	rt? ( ${CACHYOS_URI}/misc/0001-rt.patch -> ${P}-0001-rt.patch )
	bbr3? ( ${CACHYOS_URI}/0005-bbr3.patch -> ${P}-0005-bbr3.patch )
	crypto? ( ${CACHYOS_URI}/0007-crypto.patch -> ${P}-0007-crypto.patch )
	zstd? ( ${CACHYOS_URI}/0013-zstd.patch -> ${P}-0013-zstd.patch )
"
KEYWORDS="~amd64"
IUSE="+eevdf bore pds bmq +aggressive-ondemand sched-yield-type-0 +sched-yield-type-1 sched-yield-type-2 +Arch +misc-adds acs-override ntsync +glitched-base O3 +graysky +clear openrgb rt bbr3 crypto zstd"
REQUIRED_USE="
	^^ ( eevdf bore pds bmq )
	pds? ( ^^ ( sched-yield-type-0 sched-yield-type-1 sched-yield-type-2 ) )
	bmq? ( ^^ ( sched-yield-type-0 sched-yield-type-1 sched-yield-type-2 ) )
"

PATCHESDIR="${WORKDIR}/${MY_P}/linux-tkg-patches/${MY_KV}"

pkg_pretend() {
	CHECKREQS_DISK_BUILD="4G"
	check-reqs_pkg_pretend
}

src_unpack() {
	unpack "${MY_P}.tar.gz"
	kernel-2_src_unpack
}

src_prepare() {
	if use eevdf; then
		eapply "${PATCHESDIR}/0003-glitched-eevdf-additions.patch"
	elif use bore; then
		eapply "${DISTDIR}/${P}-0001-bore.patch"
	elif use pds || use bmq; then
		eapply "${PATCHESDIR}/0009-prjc_v${MY_KV}-r${PRJC_REV}.patch"

		use aggressive-ondemand && eapply "${PATCHESDIR}/0009-glitched-ondemand-bmq.patch"

		if use pds; then
			eapply "${PATCHESDIR}/0005-glitched-pds.patch"
		elif use bmq; then
			eapply "${PATCHESDIR}/0009-glitched-bmq.patch"
		fi

		local sched_yield_type
		if use sched-yield-type-0; then
			sched_yield_type="0"
		elif use sched-yield-type-1; then
			sched_yield_type="1"
		elif use sched-yield-type-2; then
			sched_yield_type="2"
		fi
		sed -i -e \
			"s/int sched_yield_type __read_mostly = 1;/int sched_yield_type __read_mostly = ${sched_yield_type};/" \
			kernel/sched/alt_core.c || die
	fi

	use Arch && eapply "${PATCHESDIR}/0001-add-sysctl-to-disallow-unprivileged-CLONE_NEWUSER-by.patch"
	use misc-adds && eapply "${PATCHESDIR}/0012-misc-additions.patch"
	use acs-override && eapply "${PATCHESDIR}/0006-add-acs-overrides_iommu.patch"
	use ntsync && eapply "${PATCHESDIR}/0007-v${MY_KV}-ntsync.patch"
	use glitched-base && eapply "${PATCHESDIR}/0003-glitched-base.patch"

	if use O3; then
		sed -i -e 's/-std=gnu11/$(CSTD_FLAG)/' "${PATCHESDIR}/0013-optimize_harder_O3.patch" || die
		eapply "${PATCHESDIR}/0013-optimize_harder_O3.patch"
	fi

	use graysky && eapply "${DISTDIR}/${P}-more-ISA-levels-and-uarches-for-kernel-6.1.79+.patch"
	use clear && eapply "${PATCHESDIR}/0002-clear-patches.patch"
	use openrgb && eapply "${PATCHESDIR}/0014-OpenRGB.patch"
	use rt && eapply "${DISTDIR}/${P}-0001-rt.patch"
	use bbr3 && eapply "${DISTDIR}/${P}-0005-bbr3.patch"
	use crypto && eapply "${DISTDIR}/${P}-0007-crypto.patch"
	use zstd && eapply "${DISTDIR}/${P}-0013-zstd.patch"

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

src_install() {
	rm -r "${WORKDIR}/${MY_P}" || die
	kernel-2_src_install
}

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}

pkg_postrm() {
	kernel-2_pkg_postrm
}
