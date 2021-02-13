# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="1"
K_SECURITY_UNSUPPORTED="1"
K_NOSETEXTRAVERSION="1"
CACULE_VERSION="r0"
ETYPE="sources"

inherit kernel-2-src-prepare-overlay
detect_version

DESCRIPTION="Xanmod and CacULE sources including the Gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
HOMEPAGE="https://github.com/hamadmarri/cacule-cpu-scheduler"
LICENSE+=" CDDL"
SRC_URI="${KERNEL_BASE_URI}/linux-5.10.tar.xz https://github.com/HougeLangley/customkernel/releases/download/Kernel-5.10-Patches/0001-patch-5.10.14-xanmod1-cacule.xz ${GENPATCHES_URI}"

UNIPATCH_LIST_DEFAULT=""
UNIPATCH_LIST="${DISTDIR}/0001-patch-5.10.14-xanmod1-cacule.xz"

KEYWORDS="~amd64"

src_prepare() {

    eapply "${FILESDIR}/0001-ZEN-Add-sysctl-and-CONFIG-to-disallow-unprivileged-CLONE_NEWUSER.patch"
    eapply "${FILESDIR}/UKSM.patch"
    
	kernel-2-src-prepare-overlay_src_prepare

}
