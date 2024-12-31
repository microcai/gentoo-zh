# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="10"
K_SECURITY_UNSUPPORTED="1"
K_NOSETEXTRAVERSION="1"

inherit check-reqs kernel-2
detect_version
detect_arch

MY_P="linux-tkg-${PV}"
MY_KV="${KV_MAJOR}.${KV_MINOR}"
PRJC_REV="0"

DESCRIPTION="Full linux-tkg sources including the Gentoo patchset for the ${MY_KV} kernel tree"
HOMEPAGE="https://github.com/Frogging-Family/linux-tkg"
TKG_URI="https://github.com/Frogging-Family/linux-tkg/archive/refs/tags/v${PV}.tar.gz -> ${MY_P}.tar.gz"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${TKG_URI}"
KEYWORDS="~amd64"
IUSE="+eevdf bore pds bmq +aggressive-ondemand sched-yield-type-0 +sched-yield-type-1 sched-yield-type-2 +Arch +misc-adds acs-override ntsync +glitched-base O3 +graysky +clear openrgb"
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
		eapply "${FILESDIR}/${PV}-0001-bore.patch"
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

	use graysky && eapply "${FILESDIR}/${PV}-more-ISA-levels-and-uarches-for-kernel-6.1.79+.patch"
	use clear && eapply "${PATCHESDIR}/0002-clear-patches.patch"
	use openrgb && eapply "${PATCHESDIR}/0014-OpenRGB.patch"

	kernel-2_src_prepare
	rm "${S}/tools/testing/selftests/tc-testing/action-ebpf"
}

pkg_setup() {
	ewarn
	ewarn "${PN} is *not* supported by the Gentoo Kernel Project in any way."
	ewarn "If you need support, please contact ${HOMEPAGE} directly."
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
