# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="1"
K_SECURITY_UNSUPPORTED="1"
K_NOSETEXTRAVERSION="1"
ETYPE="sources"
inherit kernel-2
detect_version

DESCRIPTION="Full XanMod source, including the Gentoo patchset and other patch options."
HOMEPAGE="https://xanmod.org
		https://github.com/zhmars/cjktty-patches
		https://github.com/hamadmarri/TT-CPU-Scheduler"
LICENSE+=" CDDL"
KEYWORDS="~amd64"

#
# Freeze the 'tt' use flag until the corresponding patch is released upstream.
#
#IUSE="cjktty tt"

IUSE="cjktty"
SLOT="edge"
XANMOD_VERSION="1"
XANMOD_URI="https://github.com/xanmod/linux/releases/download/"
OKV="${OKV}-xanmod"
TT_URI="https://raw.githubusercontent.com/hamadmarri/TT-CPU-Scheduler/master/patches/"
CJKTTY_URI="https://raw.githubusercontent.com/zhmars/cjktty-patches/master/v${KV_MAJOR}.x/"
SRC_URI="
	${KERNEL_BASE_URI}/linux-${KV_MAJOR}.${KV_MINOR}.tar.xz
	${GENPATCHES_URI}
	${XANMOD_URI}/${OKV}${XANMOD_VERSION}/patch-${OKV}${XANMOD_VERSION}.xz
	${CJKTTY_URI}/cjktty-${KV_MAJOR}.${KV_MINOR}.patch
"
	#${TT_URI}/${KV_MAJOR}.${KV_MINOR}/tt-${KV_MAJOR}.${KV_MINOR}.patch
	#${CJKTTY_URI}/cjktty-${KV_MAJOR}.${KV_MINOR}.patch
#"

src_unpack() {
	UNIPATCH_LIST_DEFAULT=""
	UNIPATCH_LIST="${DISTDIR}/patch-${OKV}${XANMOD_VERSION}.xz"

	#if use tt	;	then
	#	UNIPATCH_LIST+=" ${DISTDIR}/tt-${KV_MAJOR}.${KV_MINOR}.patch"
	#	UNIPATCH_LIST+=" ${FILESDIR}/localversion-tt.patch"
	#fi

	if use cjktty	;	then
		UNIPATCH_LIST+=" ${DISTDIR}/cjktty-${KV_MAJOR}.${KV_MINOR}.patch"
	fi

	kernel-2_src_unpack
}

pkg_postinst() {
	elog "MICROCODES"
	elog "Use xanmod-sources with microcodes"
	elog "Read https://wiki.gentoo.org/wiki/Intel_microcode"

	kernel-2_pkg_postinst
}

pkg_postrm() {
	kernel-2_pkg_postrm
}
