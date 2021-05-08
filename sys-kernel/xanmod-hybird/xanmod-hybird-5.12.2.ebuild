# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="1"
K_SECURITY_UNSUPPORTED="1"
K_NOSETEXTRAVERSION="1"
ETYPE="sources"
IUSE="uksm cjktty xanmod cacule"
REQUIRED_USE="^^ ( xanmod cacule )"
DEPEND="app-arch/cpio
        dev-util/dwarves
        dev-libs/libbpf
"
RDEPEND="!sys-kernel/xanmod-sources"

inherit kernel-2-src-prepare-overlay
detect_version

DESCRIPTION="Xanmod and Xanmod-CaCule sources including the Gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
HOMEPAGE="https://github.com/Frogging-Family/linux-tkg"
LICENSE+=" CDDL"
SRC_URI="${KERNEL_BASE_URI}/linux-5.12.tar.xz
        ${GENPATCHES_URI}
"

src_unpack() {
    UNIPATCH_LIST_DEFAULT=""
    kernel-2-src-prepare-overlay_src_unpack
}

KEYWORDS="~amd64"

src_prepare() {

    if  use uksm    ;   then
    eapply  "${FILESDIR}/v1-uksm.patch" ||  die
    fi

    if  use cjktty  ;   then
    eapply  "${FILESDIR}/v1-cjktty.patch"   ||  die
    fi

    if  use xanmod  ;   then
    eapply  "${FILESDIR}/patch-5.12.2-xanmod1"  ||  die
    fi

    if  use cacule  ;   then
    eapply  "${FILESDIR}/patch-5.12.2-xanmod1-cacule"   ||  die
    fi

    kernel-2-src-prepare-overlay_src_prepare
    
}

pkg_postinst() {
    elog "MICROCODES"
    elog "Use xanmod-sources with microcodes"
    elog "Read https://wiki.gentoo.org/wiki/Intel_microcode"
}
