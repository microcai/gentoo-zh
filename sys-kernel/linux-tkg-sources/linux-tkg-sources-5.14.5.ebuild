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
IUSE="+bmq pds cacule"
REQUIRED_USE="^^ ( bmq pds cacule )"

# Linux-TkG default depends pahole and bpf
DEPEND="dev-util/pahole
dev-libs/libbpf
app-arch/cpio
"

inherit kernel-2
detect_version

DESCRIPTION="Linux-TkG, cjktty, patchset for main kernel tree"
HOMEPAGE="https://github.com/Frogging-Family/linux-tkg"
LICENSE+=" CDDL"

SRC_URI="
${KERNEL_BASE_URI}/linux-5.14.tar.xz
${KERNEL_BASE_URI}/patch-${PV}.xz
${GENPATCHES_URI}
https://raw.githubusercontent.com/Frogging-Family/linux-tkg/master/linux-tkg-patches/5.14/0001-add-sysctl-to-disallow-unprivileged-CLONE_NEWUSER-by.patch -> v1-0001-add-sysctl-to-disallow-unprivileged-CLONE_NEWUSER-by.patch
https://raw.githubusercontent.com/Frogging-Family/linux-tkg/master/linux-tkg-patches/5.14/0001-mm-Support-soft-dirty-flag-reset-for-VA-range.patch -> v1-0001-mm-Support-soft-dirty-flag-reset-for-VA-range.patch
https://raw.githubusercontent.com/Frogging-Family/linux-tkg/master/linux-tkg-patches/5.14/0002-clear-patches.patch -> v1-0002-clear-patches.patch
https://gitlab.com/sirlucjan/kernel-patches/-/raw/master/5.14/ll-patches/0001-LL-kconfig-add-750Hz-timer-interrupt-kernel-config-o.patch -> v1-750HZ.patch
https://github.com/HougeLangley/customkernel/releases/download/v5.14-others/v1-cacule-5.14-full.patch
https://raw.githubusercontent.com/Frogging-Family/linux-tkg/master/linux-tkg-patches/5.14/0002-mm-Support-soft-dirty-flag-read-with-reset.patch -> v1-0002-mm-Support-soft-dirty-flag-read-with-reset.patch
https://raw.githubusercontent.com/Frogging-Family/linux-tkg/master/linux-tkg-patches/5.14/0003-glitched-base.patch -> v1-0003-glitched-base.patch
https://raw.githubusercontent.com/Frogging-Family/linux-tkg/master/linux-tkg-patches/5.14/0003-glitched-cfs-additions.patch -> v1-0003-glitched-cfs-additions.patch
https://raw.githubusercontent.com/Frogging-Family/linux-tkg/master/linux-tkg-patches/5.14/0006-add-acs-overrides_iommu.patch -> v1-0006-add-acs-overrides_iommu.patch
https://raw.githubusercontent.com/Frogging-Family/linux-tkg/master/linux-tkg-patches/5.14/0007-v5.14-futex2_interface.patch -> v1-0007-v5.14-futex2_interface.patch
https://raw.githubusercontent.com/Frogging-Family/linux-tkg/master/linux-tkg-patches/5.14/0007-v5.14-fsync.patch -> v1-0007-v5.14-fsync.patch
https://raw.githubusercontent.com/Frogging-Family/linux-tkg/master/linux-tkg-patches/5.14/0007-v5.14-winesync.patch -> v1-0007-v5.14-winesync.patch
https://gitlab.com/alfredchen/projectc/-/raw/master/5.14/prjc_v5.14-r1.patch
https://github.com/HougeLangley/customkernel/releases/download/v5.14-others/v2-0012-misc-additions.patch
https://github.com/HougeLangley/customkernel/releases/download/v5.14-others/v1-cjktty-5.14.patch
https://gitlab.com/sirlucjan/kernel-patches/-/raw/master/5.14/bbr2-patches/0001-bbr2-5.14-introduce-BBRv2.patch -> v1-bbr2.patch
https://github.com/HougeLangley/customkernel/releases/download/v5.14-others/v2-0001-cpu-5.14-merge-graysky-s-patchset.patch -> v2-gcc-01.patch
https://github.com/HougeLangley/customkernel/releases/download/v5.14-others/v2-0003-init-Kconfig-add-O1-flag.patch -> v2-gcc-03.patch
https://github.com/HougeLangley/customkernel/releases/download/v5.14-others/v2-0004-Makefile-Turn-off-loop-vectorization-for-GCC-O3-opti.patch -> v2-gcc-04.patch
https://gitlab.com/sirlucjan/kernel-patches/-/raw/master/5.14/bcachefs-patches/0001-bcachefs-5.14-introduce-bcachefs-patchset.patch -> v1-bcachefs.patch
"
KEYWORDS="~amd64"

S="${WORKDIR}/linux-${PV}-linux"

UNIPATCH_LIST_DEFAULT=( "${DISTDIR}/patch-${PV}.xz" )

PATCHES=( "${DISTDIR}/v1-0001-add-sysctl-to-disallow-unprivileged-CLONE_NEWUSER-by.patch"
"${DISTDIR}/v1-0001-mm-Support-soft-dirty-flag-reset-for-VA-range.patch"
"${DISTDIR}/v1-0002-clear-patches.patch"
"${DISTDIR}/v1-750HZ.patch"
"${DISTDIR}/v1-cacule-5.14-full.patch"
"${DISTDIR}/v1-0002-mm-Support-soft-dirty-flag-read-with-reset.patch"
"${DISTDIR}/v1-0003-glitched-base.patch"
"${DISTDIR}/v1-0003-glitched-cfs-additions.patch"
"${DISTDIR}/v1-0006-add-acs-overrides_iommu.patch"
"${DISTDIR}/v1-0007-v5.14-futex2_interface.patch"
"${DISTDIR}/v1-0007-v5.14-fsync.patch"
"${DISTDIR}/v1-0007-v5.14-winesync.patch"
"${DISTDIR}/prjc_v5.14-r1.patch"
"${DISTDIR}/v2-0012-misc-additions.patch"
"${DISTDIR}/v1-cjktty-5.14.patch"
"${DISTDIR}/v1-bbr2.patch"
"${DISTDIR}/v2-gcc-01.patch"
"${DISTDIR}/v2-gcc-03.patch"
"${DISTDIR}/v2-gcc-04.patch"
"${DISTDIR}/v1-bcachefs.patch" )

K_EXTRAEINFO="For more info on linux-tkg-sources and details on how to report problems, see: ${HOMEPAGE}."

src_prepare() {
	# Default apply Linux-TkG BMQ patches, Do not forget copy BMQ.config to .config.
	if	use	bmq	;	then
		eapply "${DISTDIR}/v1-0001-add-sysctl-to-disallow-unprivileged-CLONE_NEWUSER-by.patch"	||	die
		eapply "${DISTDIR}/v1-0001-mm-Support-soft-dirty-flag-reset-for-VA-range.patch"	||	die
		eapply "${DISTDIR}/v1-0002-clear-patches.patch"	||	die
		eapply "${DISTDIR}/v1-750HZ.patch"	||	die
		eapply "${DISTDIR}/v1-0002-mm-Support-soft-dirty-flag-read-with-reset.patch"	||	die
		eapply "${DISTDIR}/v1-0003-glitched-base.patch"	||	die
		eapply "${DISTDIR}/v1-0003-glitched-cfs-additions.patch"	||	die
		eapply "${DISTDIR}/v1-0006-add-acs-overrides_iommu.patch"	||	die
		eapply "${DISTDIR}/v1-0007-v5.14-futex2_interface.patch"	|| die
		eapply "${DISTDIR}/v1-0007-v5.14-fsync.patch"	||	die
		eapply "${DISTDIR}/v1-0007-v5.14-winesync.patch"	||	die
		eapply "${DISTDIR}/prjc_v5.14-r1.patch"	||	die
		eapply "${DISTDIR}/v2-0012-misc-additions.patch"	||	die
		eapply "${DISTDIR}/v1-cjktty-5.14.patch"	||	die
		eapply "${DISTDIR}/v1-bbr2.patch"	||	die
		eapply "${DISTDIR}/v2-gcc-01.patch"	||	die
		eapply "${DISTDIR}/v2-gcc-03.patch"	||	die
		eapply "${DISTDIR}/v2-gcc-04.patch"	||	die
		eapply "${DISTDIR}/v1-bcachefs.patch"	||	die
	fi
	# Apply Linux-TkG PDS patches, Do not forget copy PDS.config to .config.
	if	use	pds	;	then
		eapply "${DISTDIR}/v1-0001-add-sysctl-to-disallow-unprivileged-CLONE_NEWUSER-by.patch"	||	die
		eapply "${DISTDIR}/v1-0001-mm-Support-soft-dirty-flag-reset-for-VA-range.patch"	||	die
		eapply "${DISTDIR}/v1-0002-clear-patches.patch"	||	die
		eapply "${DISTDIR}/v1-750HZ.patch"	||	die
		eapply "${DISTDIR}/v1-0002-mm-Support-soft-dirty-flag-read-with-reset.patch"	||	die
		eapply "${DISTDIR}/v1-0003-glitched-base.patch"	||	die
		eapply "${DISTDIR}/v1-0003-glitched-cfs-additions.patch"	||	die
		eapply "${DISTDIR}/v1-0006-add-acs-overrides_iommu.patch"	||	die
		eapply "${DISTDIR}/v1-0007-v5.14-futex2_interface.patch"	|| die
		eapply "${DISTDIR}/v1-0007-v5.14-fsync.patch"	||	die
		eapply "${DISTDIR}/v1-0007-v5.14-winesync.patch"	||	die
		eapply "${DISTDIR}/prjc_v5.14-r1.patch"	||	die
		eapply "${DISTDIR}/v2-0012-misc-additions.patch"	||	die
		eapply "${DISTDIR}/v1-cjktty-5.14.patch"	||	die
		eapply "${DISTDIR}/v1-bbr2.patch"	||	die
		eapply "${DISTDIR}/v2-gcc-01.patch"	||	die
		eapply "${DISTDIR}/v2-gcc-03.patch"	||	die
		eapply "${DISTDIR}/v2-gcc-04.patch"	||	die
		eapply "${DISTDIR}/v1-bcachefs.patch"	||	die
	fi
	# Apply Linux-TKG CacULE patches
	if	use	cacule	;	then
		eapply "${DISTDIR}/v1-0001-add-sysctl-to-disallow-unprivileged-CLONE_NEWUSER-by.patch"	||	die
		eapply "${DISTDIR}/v1-0001-mm-Support-soft-dirty-flag-reset-for-VA-range.patch"	||	die
		eapply "${DISTDIR}/v1-0002-clear-patches.patch"	||	die
		eapply "${DISTDIR}/v1-750HZ.patch"	||	die
		eapply "${DISTDIR}/v1-cacule-5.14-full.patch"	||	die
		eapply "${DISTDIR}/v1-0002-mm-Support-soft-dirty-flag-read-with-reset.patch"	||	die
		eapply "${DISTDIR}/v1-0003-glitched-base.patch"	||	die
		eapply "${DISTDIR}/v1-0006-add-acs-overrides_iommu.patch"	||	die
		eapply "${DISTDIR}/v1-0007-v5.14-futex2_interface.patch"	|| die
		eapply "${DISTDIR}/v1-0007-v5.14-fsync.patch"	||	die
		eapply "${DISTDIR}/v1-0007-v5.14-winesync.patch"	||	die
		eapply "${DISTDIR}/v2-0012-misc-additions.patch"	||	die
		eapply "${DISTDIR}/v1-cjktty-5.14.patch"	||	die
		eapply "${DISTDIR}/v1-bbr2.patch"	||	die
		eapply "${DISTDIR}/v2-gcc-01.patch"	||	die
		eapply "${DISTDIR}/v2-gcc-03.patch"	||	die
		eapply "${DISTDIR}/v2-gcc-04.patch"	||	die
		eapply "${DISTDIR}/v1-bcachefs.patch"	||	die
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
