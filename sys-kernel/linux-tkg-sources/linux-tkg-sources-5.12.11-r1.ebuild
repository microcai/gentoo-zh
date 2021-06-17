# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# Define what default functions to run
ETYPE="sources"

# No 'experimental' USE flag provided, but we still want to use genpatches
K_EXP_GENPATCHES_NOUSE="1"

# Just get basic genpatches, -xanmod patch set already includes main updates
K_GENPATCHES_VER="1"

# -linux-tkg-bmq-sources already sets EXTRAVERSION to kernel Makefile
K_NOSETEXTRAVERSION="1"

# Not supported by the Gentoo security team
K_SECURITY_UNSUPPORTED="1"

# We want the very basic patches from gentoo-sources, experimental patch is
# already included in -linux-tkg-bmq-sources
K_WANT_GENPATCHES="base extras"

# Default enable BMQ, Because I do think this one is best of them.
# If you want to choose other, USE could be help you.
IUSE="+bmq pds muqss"
REQUIRED_USE="^^ ( bmq pds muqss )"

# Linux-TkG default depends pahole and bpf
DEPEND="dev-util/pahole
dev-libs/libbpf
"

inherit kernel-2
detect_version

DESCRIPTION="Linux-TkG, cjktty, uksm patchset for main kernel tree"
HOMEPAGE="https://github.com/Frogging-Family/linux-tkg"
LICENSE+=" CDDL"

SRC_URI="
${KERNEL_BASE_URI}/linux-5.12.tar.xz
${KERNEL_BASE_URI}/patch-5.12.11.xz
${GENPATCHES_URI}
https://raw.githubusercontent.com/Frogging-Family/linux-tkg/master/linux-tkg-patches/5.12/0001-add-sysctl-to-disallow-unprivileged-CLONE_NEWUSER-by.patch
https://raw.githubusercontent.com/Frogging-Family/linux-tkg/master/linux-tkg-patches/5.12/0001-mm-Support-soft-dirty-flag-reset-for-VA-range.patch
https://raw.githubusercontent.com/Frogging-Family/linux-tkg/master/linux-tkg-patches/5.12/0002-clear-patches.patch
https://raw.githubusercontent.com/Frogging-Family/linux-tkg/master/linux-tkg-patches/5.12/0002-mm-Support-soft-dirty-flag-read-with-reset.patch
https://raw.githubusercontent.com/Frogging-Family/linux-tkg/master/linux-tkg-patches/5.12/0003-glitched-base.patch
http://ck.kolivas.org/patches/muqss/5.0/5.12/0001-MultiQueue-Skiplist-Scheduler-v0.210.patch -> 0004-muqss.patch
https://gitlab.com/alfredchen/projectc/-/raw/master/5.12/prjc_v5.12-r1.patch -> 0004-prjc-r1.patch
https://gitlab.com/sirlucjan/kernel-patches/-/raw/master/5.12/prjc-patches-fixes-v3/0001-prjc-5.12-fix-compilation-error-if-sched_feat-UTIL_E.patch -> 0004-prjc-fix-v3.patch
https://raw.githubusercontent.com/Frogging-Family/linux-tkg/master/linux-tkg-patches/5.12/0006-add-acs-overrides_iommu.patch
https://raw.githubusercontent.com/Frogging-Family/linux-tkg/master/linux-tkg-patches/5.12/0007-v5.12-fsync.patch
https://raw.githubusercontent.com/Frogging-Family/linux-tkg/master/linux-tkg-patches/5.12/0007-v5.12-futex2_interface.patch
https://raw.githubusercontent.com/Frogging-Family/linux-tkg/master/linux-tkg-patches/5.12/0007-v5.12-winesync.patch
https://raw.githubusercontent.com/Frogging-Family/linux-tkg/master/linux-tkg-patches/5.12/0012-misc-additions.patch
https://github.com/HougeLangley/customkernel/releases/download/v5.12-others/v1-cjktty.patch
https://github.com/HougeLangley/customkernel/releases/download/v5.12-others/v1-uksm.patch
https://gitlab.com/sirlucjan/kernel-patches/-/raw/master/5.12/bbr2-patches-v2/0001-bbr2-5.12-introduce-BBRv2.patch -> v2-bbr2.patch
https://gitlab.com/sirlucjan/kernel-patches/-/raw/master/5.12/cpu-patches-v5-sep/0001-cpu-5.12-merge-graysky-s-patchset.patch -> v5-graysky.patch
"
KEYWORDS="~amd64"

S="${WORKDIR}/linux-5.12.11-linux-r1"

UNIPATCH_LIST_DEFAULT=( "${DISTDIR}/patch-5.12.11.xz" )

PATCHES=( "${DISTDIR}/0001-add-sysctl-to-disallow-unprivileged-CLONE_NEWUSER-by.patch"
"${DISTDIR}/0001-mm-Support-soft-dirty-flag-reset-for-VA-range.patch"
"${DISTDIR}/0002-clear-patches.patch"
"${DISTDIR}/0002-mm-Support-soft-dirty-flag-read-with-reset.patch"
"${DISTDIR}/0003-glitched-base.patch"
"${DISTDIR}/0004-muqss.patch"
"${DISTDIR}/0004-prjc-r1.patch"
"${DISTDIR}/0004-prjc-fix-v3.patch"
"${DISTDIR}/0006-add-acs-overrides_iommu.patch"
"${DISTDIR}/0007-v5.12-fsync.patch"
"${DISTDIR}/0007-v5.12-futex2_interface.patch"
"${DISTDIR}/0007-v5.12-winesync.patch"
"${DISTDIR}/0012-misc-additions.patch"
"${DISTDIR}/v1-cjktty.patch"
"${DISTDIR}/v1-uksm.patch"
"${DISTDIR}/v2-bbr2.patch"
"${DISTDIR}/v5-graysky.patch" )

K_EXTRAEINFO="For more info on linux-tkg-sources and details on how to report problems, see: ${HOMEPAGE}."

src_prepare() {
	# Default apply Linux-TkG BMQ patches, Do not forget copy BMQ.config to .config.
	if	use	bmq	;	then
		eapply "${DISTDIR}/0001-add-sysctl-to-disallow-unprivileged-CLONE_NEWUSER-by.patch"	||	die
		eapply "${DISTDIR}/0001-mm-Support-soft-dirty-flag-reset-for-VA-range.patch"	||	die
		eapply "${DISTDIR}/0002-mm-Support-soft-dirty-flag-read-with-reset.patch"	||	die
		eapply "${DISTDIR}/0002-clear-patches.patch"	||	die
		eapply "${DISTDIR}/0003-glitched-base.patch"	||	die
		eapply "${DISTDIR}/0004-prjc-r1.patch"	||	die
		eapply "${DISTDIR}/0004-prjc-fix-v3.patch"	||	die
		eapply "${DISTDIR}/0006-add-acs-overrides_iommu.patch"	|| die
		eapply "${DISTDIR}/0007-v5.12-fsync.patch"	||	die
		eapply "${DISTDIR}/0007-v5.12-futex2_interface.patch"	||	die
		eapply "${DISTDIR}/0007-v5.12-winesync.patch"	||	die
		eapply "${DISTDIR}/0012-misc-additions.patch"	||	die
		eapply "${DISTDIR}/v1-cjktty.patch"	||	die
		eapply "${DISTDIR}/v1-uksm.patch"	||	die
		eapply "${DISTDIR}/v2-bbr2.patch"	||	die
		eapply "${DISTDIR}/v5-graysky.patch"	|| die
	fi
	# Apply Linux-TkG PDS patches, Do not forget copy PDS.config to .config.
	if	use	pds	;	then
		eapply "${DISTDIR}/0001-add-sysctl-to-disallow-unprivileged-CLONE_NEWUSER-by.patch"	||	die
		eapply "${DISTDIR}/0001-mm-Support-soft-dirty-flag-reset-for-VA-range.patch"	||	die
		eapply "${DISTDIR}/0002-mm-Support-soft-dirty-flag-read-with-reset.patch"	||	die
		eapply "${DISTDIR}/0002-clear-patches.patch"	||	die
		eapply "${DISTDIR}/0003-glitched-base.patch"	||	die
		eapply "${DISTDIR}/0004-prjc-r1.patch"	||	die
		eapply "${DISTDIR}/0004-prjc-fix-v3.patch"	||	die
		eapply "${DISTDIR}/0006-add-acs-overrides_iommu.patch"	|| die
		eapply "${DISTDIR}/0007-v5.12-fsync.patch"	||	die
		eapply "${DISTDIR}/0007-v5.12-futex2_interface.patch"	||	die
		eapply "${DISTDIR}/0007-v5.12-winesync.patch"	||	die
		eapply "${DISTDIR}/0012-misc-additions.patch"	||	die
		eapply "${DISTDIR}/v1-cjktty.patch"	||	die
		eapply "${DISTDIR}/v1-uksm.patch"	||	die
		eapply "${DISTDIR}/v2-bbr2.patch"	||	die
		eapply "${DISTDIR}/v5-graysky.patch"	|| die
	fi
	# Apply Linux-TKG MuQSS patches
	if	use	muqss	;	then
		eapply "${DISTDIR}/0001-add-sysctl-to-disallow-unprivileged-CLONE_NEWUSER-by.patch"	||	die
		eapply "${DISTDIR}/0001-mm-Support-soft-dirty-flag-reset-for-VA-range.patch"	||	die
		eapply "${DISTDIR}/0002-mm-Support-soft-dirty-flag-read-with-reset.patch"	||	die
		eapply "${DISTDIR}/0002-clear-patches.patch"	||	die
		eapply "${DISTDIR}/0003-glitched-base.patch"	||	die
		eapply "${DISTDIR}/0004-muqss.patch"	||	die
		eapply "${DISTDIR}/0006-add-acs-overrides_iommu.patch"	||	die
		eapply "${DISTDIR}/0007-v5.12-fsync.patch"	||	die
		eapply "${DISTDIR}/0007-v5.12-futex2_interface.patch"	||	die
		eapply "${DISTDIR}/0007-v5.12-winesync.patch"	||	die
		eapply "${DISTDIR}/0012-misc-additions.patch"	||	die
		eapply "${DISTDIR}/v1-cjktty.patch"	||	die
		eapply "${DISTDIR}/v1-uksm.patch"	||	die
		eapply "${DISTDIR}/v2-bbr2.patch"	||	die
		eapply "${DISTDIR}/v5-graysky.patch"	|| die
	fi

	kernel-2_src_prepare
}

pkg_setup() {
	ewarn ""
	ewarn "${PN} is *not* supported by the Gentoo Kernel Project in any way."
	ewarn "If you need support, please contact the ${HOMEPAGE} directly."
	ewarn "Do *not* open bugs in Gentoo's bugzilla unless you have issues with"
	ewarn "the ebuilds. Thank you."
	ewarn ""

	kernel-2_pkg_setup
}

pkg_postinst() {
	elog "MICROCODES"
	elog "Use linux-tkg-sources with microcodes"
	elog "Read https://wiki.gentoo.org/wiki/Intel_microcode"
}
