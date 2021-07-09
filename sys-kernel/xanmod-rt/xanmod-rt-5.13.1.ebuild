# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# Define what default functions to run
ETYPE="sources"

# No 'experimental' USE flag provided, but we still want to use genpatches
K_EXP_GENPATCHES_NOUSE="1"

# Just get basic genpatches, -xanmod patch set already includes main updates
K_GENPATCHES_VER="1"

# -xanmod-rt already sets EXTRAVERSION to kernel Makefile
K_NOSETEXTRAVERSION="1"

# Not supported by the Gentoo security team
K_SECURITY_UNSUPPORTED="1"

# We want the very basic patches from gentoo-sources, experimental patch is
# already included in xanmod-rt
K_WANT_GENPATCHES="base extras"

# If you have been enable src_prepare-overlay
# please unmerge sys-kernel/xanmod-sources
RDEPEND="
	!sys-kernel/xanmod-sources
	!sys-kernel/xanmod-hybrid
"

inherit kernel-2
detect_version

DESCRIPTION="Xanmod-RT, cjktty, uksm patchset for main kernel tree"
HOMEPAGE="https://github.com/HougeLangley/customkernel"
LICENSE+=" CDDL"

SRC_URI="
${KERNEL_BASE_URI}/linux-5.13.tar.xz
${GENPATCHES_URI}
https://github.com/xanmod/linux/releases/download/5.13.1-rt1-xanmod1/patch-5.13.1-rt1-xanmod1.xz
https://github.com/HougeLangley/customkernel/releases/download/v5.13-others/v1-cjktty.patch.xz
https://github.com/HougeLangley/customkernel/releases/download/v5.13-others/v1-uksm.patch.xz
"
KEYWORDS="~amd64"

S="${WORKDIR}/linux-${PV}-xanmod"

K_EXTRAEINFO="For more info on xanmod-rt and details on how to report problems,	see: ${HOMEPAGE}."

UNIPATCH_LIST="${DISTDIR}/patch-5.13.1-rt1-xanmod1.xz ${DISTDIR}/v1-cjktty.patch.xz ${DISTDIR}/v1-uksm.patch.xz"

pkg_setup() {
	ewarn ""
	ewarn "${PN} is *NOT* supported by the Gentoo Kernel Project in any way."
	ewarn "If you need support, please contact the ${HOMEPAGE} directly."
	ewarn "Do *NOT* open bugs in Gentoo's bugzilla unless you have issues with"
	ewarn "the ebuilds. Thank you."
	ewarn ""
	ewarn "${PN} is *NOT* supported by openZFS."
	ewarn "${PN} is *NOT* supported by NVIDIA Driver."
	ewarn ""
	kernel-2_pkg_setup
}

pkg_postinst() {
	elog "MICROCODES"
	elog "Use xanmod-rt with microcodes"
	elog "Read https://wiki.gentoo.org/wiki/Intel_microcode"
}
