# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="1"
K_SECURITY_UNSUPPORTED="1"
K_NOSETEXTRAVERSION="1"
PROJECTC_VERSION="r2"
ETYPE="sources"

inherit kernel-2-src-prepare-overlay
detect_version

DESCRIPTION="Full Project-C CPU Scheduler sources including the Gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
HOMEPAGE="https://cchalpha.blogspot.com/"
LICENSE+=" CDDL"
SRC_URI="${KERNEL_BASE_URI}/linux-5.10.tar.xz https://github.com/HougeLangley/customkernel/releases/download/Kernel-5.10-Patches/0001-patch-5.10.6.xz https://github.com/HougeLangley/customkernel/releases/download/Kernel-5.10-Patches/0002-prjc_v5.10-r2.xz ${GENPATCHES_URI}"

UNIPATCH_LIST_DEFAULT=""
UNIPATCH_LIST="${DISTDIR}/0001-patch-5.10.6.xz ${DISTDIR}/0002-prjc_v5.10-r2.xz"

KEYWORDS="~amd64"

src_prepare() {

    eapply "${FILESDIR}/0001-add.patch"
    eapply "${FILESDIR}/0002-base.patch"
    eapply "${FILESDIR}/0003-pds.patch"
    eapply "${FILESDIR}/0004-acs.patch"
    eapply "${FILESDIR}/0005-fsync.patch"
    eapply "${FILESDIR}/0006-UKSM.patch"
    eapply "${FILESDIR}/0007-graysky.patch"
    eapply "${FILESDIR}/0010-misc.patch"

	kernel-2-src-prepare-overlay_src_prepare

}
