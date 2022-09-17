# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
K_WANT_GENPATCHES="base extras"
#Note: to bump xanmod, check K_GENPATCHES_VER in sys-kernel/gentoo-sources
K_GENPATCHES_VER="72"
K_SECURITY_UNSUPPORTED="1"
K_NOSETEXTRAVERSION="1"
ETYPE="sources"
inherit kernel-2
detect_version

DESCRIPTION="Full XanMod source, including the Gentoo patchset and other patch options."
HOMEPAGE="https://xanmod.org
		https://github.com/zhmars/cjktty-patches"
LICENSE+=" CDDL"
KEYWORDS="~amd64"

IUSE="cjktty"
SLOT="stable"
XANMOD_VERSION="1"
XANMOD_URI="https://github.com/xanmod/linux/releases/download/"
OKV="${OKV}-xanmod"
CJKTTY_URI="https://raw.githubusercontent.com/zhmars/cjktty-patches/master/v${KV_MAJOR}.x/"
SRC_URI="
	${KERNEL_BASE_URI}/linux-${KV_MAJOR}.${KV_MINOR}.tar.xz
	${GENPATCHES_URI}
	${XANMOD_URI}/${OKV}${XANMOD_VERSION}/patch-${OKV}${XANMOD_VERSION}.xz
	${CJKTTY_URI}/cjktty-${KV_MAJOR}.${KV_MINOR}.patch
"

src_unpack() {
	universal_unpack
	mkdir "${WORKDIR}/genpatches" || die
	for i in ${K_WANT_GENPATCHES}; do
		tar xf "${DISTDIR}/genpatches-${KV_MAJOR}.${KV_MINOR}-${K_GENPATCHES_VER}.${i}.tar.xz" -C "${WORKDIR}/genpatches"
	done

	rm "${WORKDIR}"/genpatches/*linux-"${KV_MAJOR}"."${KV_MINOR}"*.patch || die

	UNIPATCH_LIST=""
	for i in $(dir "${WORKDIR}"/genpatches/*.patch); do
		UNIPATCH_LIST+=" ${i}"
	done

	if use cjktty; then
		UNIPATCH_LIST+=" ${DISTDIR}/cjktty-${KV_MAJOR}.${KV_MINOR}.patch"
	fi

	UNIPATCH_LIST+=" ${DISTDIR}/patch-${OKV}${XANMOD_VERSION}.xz"

	unipatch "${UNIPATCH_LIST}"
	unpack_fix_install_path
	env_setup_xmakeopts
	cd "${S}" || die
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
