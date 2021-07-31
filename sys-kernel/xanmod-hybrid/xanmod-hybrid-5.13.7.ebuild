# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# Define what default functions to run
ETYPE="sources"

# No 'experimental' USE flag provided, but we still want to use genpatches
K_EXP_GENPATCHES_NOUSE="1"

# Just get basic genpatches, -xanmod patch set already includes main updates
K_GENPATCHES_VER="1"

# -xanmod-hybrid already sets EXTRAVERSION to kernel Makefile
K_NOSETEXTRAVERSION="1"

# Not supported by the Gentoo security team
K_SECURITY_UNSUPPORTED="1"

# We want the very basic patches from gentoo-sources, experimental patch is
# already included in xanmod-hybrid
K_WANT_GENPATCHES="base extras"

# Default enable Xanmod, You have to choose one of them.
# Both of them will make some errors
IUSE="+xanmod cacule"
REQUIRED_USE="^^ ( xanmod cacule )"

# If you have been enable src_prepare-overlay
# please unmerge sys-kernel/xanmod-sources
RDEPEND="
	!sys-kernel/xanmod-sources
	!sys-kernel/xanmod-rt
"

inherit kernel-2
detect_version

DESCRIPTION="Xanmod, Xanmod-CaCule, cjktty, uksm patchset for main kernel tree"
HOMEPAGE="https://github.com/HougeLangley/customkernel"
LICENSE+=" CDDL"

SRC_URI="
${KERNEL_BASE_URI}/linux-5.13.tar.xz
${GENPATCHES_URI}
https://github.com/HougeLangley/customkernel/releases/download/v5.13-patch/patch-5.13.7-xanmod1
https://github.com/HougeLangley/customkernel/releases/download/v5.13-patch/patch-5.13.7-xanmod1-cacule
https://github.com/HougeLangley/customkernel/releases/download/v5.13-others/v1-cjktty.patch
https://github.com/HougeLangley/customkernel/releases/download/v5.13-others/v1-uksm.patch
"
KEYWORDS="~amd64"

S="${WORKDIR}/linux-${PV}-xanmod"

K_EXTRAEINFO="For more info on xanmod-hybrid and details on how to report problems,	see: ${HOMEPAGE}."

PATCHES=( "${DISTDIR}/patch-5.13.7-xanmod1"
"${DISTDIR}/patch-5.13.7-xanmod1-cacule"
"${DISTDIR}/v1-cjktty.patch"
"${DISTDIR}/v1-uksm.patch" )

src_prepare() {
	# Default enable Xanmod
	if	use	xanmod	;	then
		eapply "${DISTDIR}/patch-5.13.7-xanmod1"	||	die
		eapply "${DISTDIR}/v1-cjktty.patch"	||	die
		eapply "${DISTDIR}/v1-uksm.patch"	||	die
	fi
	# Enable Xanmod-CaCule
	if	use	cacule	;	then
		eapply "${DISTDIR}/patch-5.13.7-xanmod1-cacule"	||	die
		eapply "${DISTDIR}/v1-cjktty.patch"	||	die
		eapply "${DISTDIR}/v1-uksm.patch"	||	die
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
	elog "Use xanmod-hybrid with microcodes"
	elog "Read https://wiki.gentoo.org/wiki/Intel_microcode"
}
