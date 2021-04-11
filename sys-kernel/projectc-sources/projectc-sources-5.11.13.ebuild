# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="1"
K_SECURITY_UNSUPPORTED="1"
K_NOSETEXTRAVERSION="1"
PROJECTC_VERSION="r3"
ETYPE="sources"
IUSE="uksm cjktty"
DEPEND="app-arch/cpio
        dev-util/dwarves
        dev-libs/libbpf"

inherit kernel-2-src-prepare-overlay
detect_version

DESCRIPTION="Full Project-C CPU Scheduler sources including the Gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
HOMEPAGE="https://cchalpha.blogspot.com/"
LICENSE+=" CDDL"
SRC_URI="${KERNEL_BASE_URI}/linux-5.11.tar.xz
         https://github.com/HougeLangley/customkernel/releases/download/Kernel-v5.11.x/0001-patch-5.11.13.xz
         https://github.com/HougeLangley/customkernel/releases/download/Kernel-v5.11.x/0002-prjc_v5.11-r3.patch.xz
         ${GENPATCHES_URI}
"

src_unpack() {
    UNIPATCH_LIST_DEFAULT=""
    UNIPATCH_LIST="${DISTDIR}/0001-patch-5.11.13.xz
                   ${DISTDIR}/0002-prjc_v5.11-r3.patch.xz
"
    kernel-2-src-prepare-overlay_src_unpack
}

KEYWORDS="~amd64"

src_prepare() {

    default
    eapply "${FILESDIR}/0001-add.patch"
    eapply "${FILESDIR}/0002-base.patch"
    eapply "${FILESDIR}/0003-pds.patch"
    eapply "${FILESDIR}/0004-acs.patch"
    eapply "${FILESDIR}/0005-fsync.patch"
    eapply "${FILESDIR}/0007-graysky.patch"
    eapply "${FILESDIR}/0008-futex2_interface.patch"
    eapply "${FILESDIR}/0010-bbr2.patch"
    eapply "${FILESDIR}/0011-03-misc.patch"

    if use uksm ; then
    eapply "${FILESDIR}/UKSM-reversion01.patch" || die
    fi

    if use cjktty ; then
    eapply "${FILESDIR}/cjktty.patch" || die
    fi
    
	kernel-2-src-prepare-overlay_src_prepare

}

pkg_postinst() {
	elog "MICROCODES"
	elog "Read https://wiki.gentoo.org/wiki/Intel_microcode"
}