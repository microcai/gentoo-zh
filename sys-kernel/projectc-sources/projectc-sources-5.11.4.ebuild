# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="1"
K_SECURITY_UNSUPPORTED="1"
K_NOSETEXTRAVERSION="1"
PROJECTC_VERSION="r0"
ETYPE="sources"

inherit kernel-2-src-prepare-overlay
detect_version

DESCRIPTION="Full Project-C CPU Scheduler sources including the Gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
HOMEPAGE="https://cchalpha.blogspot.com/"
LICENSE+=" CDDL"
SRC_URI="${KERNEL_BASE_URI}/linux-5.11.tar.xz https://github.com/HougeLangley/customkernel/releases/download/Kernel-v5.11.x/0001-patch-5.11.4.xz https://github.com/HougeLangley/customkernel/releases/download/Kernel-v5.11.x/0002-prjc_v5.11-r2.patch.xz ${GENPATCHES_URI}"

UNIPATCH_LIST_DEFAULT=""
UNIPATCH_LIST="${DISTDIR}/0001-patch-5.11.4.xz ${DISTDIR}/0002-prjc_v5.11-r2.patch.xz"

KEYWORDS="~amd64"

src_prepare() {

    eapply "${FILESDIR}/0001-add.patch"
    eapply "${FILESDIR}/0002-base.patch"
    eapply "${FILESDIR}/0003-pds.patch"
    eapply "${FILESDIR}/0004-acs.patch"
    eapply "${FILESDIR}/0005-fsync.patch"
    eapply "${FILESDIR}/0006-UKSM-reversion01.patch"
    eapply "${FILESDIR}/0007-graysky.patch"
    eapply "${FILESDIR}/0008-futex2_interface.patch"
    eapply "${FILESDIR}/0011-03-misc.patch"

	kernel-2-src-prepare-overlay_src_prepare

}
