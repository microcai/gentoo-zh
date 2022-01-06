# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Define what default functions to run
ETYPE="sources"

# No 'experimental' USE flag provided, but we still want to use genpatches
K_EXP_GENPATCHES_NOUSE="1"

# Just get basic genpatches, -xanmod patch set already includes main updates
K_GENPATCHES_VER="2"

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
${KERNEL_BASE_URI}/linux-5.15.tar.xz
${GENPATCHES_URI}
https://github.com/xanmod/linux/releases/download/5.15.8-rt23-xanmod2/patch-5.15.8-rt23-xanmod2.xz
https://github.com/HougeLangley/customkernel/releases/download/v5.15-others/v1-cjktty.patch.xz
"
KEYWORDS="~amd64"

S="${WORKDIR}/linux-${PV}-xanmod-r1"

K_EXTRAEINFO="For more info on xanmod-rt and details on how to report problems,	see: ${HOMEPAGE}."

UNIPATCH_LIST="${DISTDIR}/patch-5.15.8-rt23-xanmod2.xz ${DISTDIR}/v1-cjktty.patch.xz"

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
