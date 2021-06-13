# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# Define what default functions to run
ETYPE="sources"

# No 'experimental' USE flag provided, but we still want to use genpatches
K_EXP_GENPATCHES_NOUSE="1"

# Just get basic genpatches, -xanmod patch set already includes main updates
K_GENPATCHES_VER="1"

# -pf already sets EXTRAVERSION to kernel Makefile
K_NOSETEXTRAVERSION="1"

# Not supported by the Gentoo security team
K_SECURITY_UNSUPPORTED="1"

# We want the very basic patches from gentoo-sources, experimental patch is
# already included in pf-sources
K_WANT_GENPATCHES="base extras"

DEPEND="app-arch/cpio
dev-util/pahole
dev-libs/libbpf
"
RDEPEND="
!sys-kernel/xanmod-sources
!sys-kernel/xanmod-cacule-hybrid
"

inherit kernel-2
detect_version

DESCRIPTION="Xanmod, cjktty, uksm patchset for main kernel tree"
HOMEPAGE="https://github.com/HougeLangley/customkernel"
LICENSE+=" CDDL"
SRC_URI="
${KERNEL_BASE_URI}/linux-5.12.tar.xz
https://github.com/xanmod/linux/releases/download/5.12.10-xanmod1/patch-5.12.10-xanmod1.xz
https://github.com/HougeLangley/customkernel/releases/download/v5.12-others/v1-cjktty.patch
https://github.com/HougeLangley/customkernel/releases/download/v5.12-others/v1-uksm.patch
${GENPATCHES_URI}
"
KEYWORDS="~amd64"

S="${WORKDIR}/linux-${PVR}-xanmod"

UNIPATCH_LIST_DEFAULT="${DISTDIR}/patch-5.12.10-xanmod1.xz ${DISTDIR}/v1-cjktty.patch ${DISTDIR}/v1-uksm.patch"

K_EXTRAEINFO="For more info on xanmod-hybrid and details on how to report problems,	see: ${HOMEPAGE}."

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
	elog "Use xanmod-sources with microcodes"
	elog "Read https://wiki.gentoo.org/wiki/Intel_microcode"
}
