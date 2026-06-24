# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
ETYPE="sources"
K_WANT_GENPATCHES=""
# Note: to bump xanmod, check PATCHSET in sys-kernel/gentoo-kernel
PATCHSET=linux-gentoo-patches-${PV}

inherit check-reqs kernel-2
detect_version
detect_arch

MY_P=linux-${PV%.*}
DESCRIPTION="Full XanMod source, including the Gentoo patchset and other patch options."
HOMEPAGE="https://xanmod.org"

XANMOD_VERSION="1"
XANMOD_URI="https://downloads.sourceforge.net/project/xanmod/releases/main"
OKV="${OKV}-xanmod"
SRC_URI="
	${KERNEL_BASE_URI}/linux-${KV_MAJOR}.${KV_MINOR}.tar.xz
	https://distfiles.gentoo.org/pub/proj/dist-kernel/patchsets/$(ver_cut 1-2)/${PATCHSET}.tar.xz
	${XANMOD_URI}/${PV}-xanmod${XANMOD_VERSION}/patch-${PV}-xanmod${XANMOD_VERSION}.xz
"
S="${WORKDIR}/linux-${OKV}${XANMOD_VERSION}"

LICENSE+=" CDDL"
KEYWORDS="~amd64"

pkg_pretend() {
	CHECKREQS_DISK_BUILD="4G"
	check-reqs_pkg_pretend
}

src_unpack() {
	default
	mv "${WORKDIR}/${MY_P}" "${WORKDIR}/linux-${OKV}${XANMOD_VERSION}"
}

src_prepare() {
	kernel-2_src_prepare
	rm "${S}/tools/testing/selftests/tc-testing/action-ebpf"

	local PATCHES=(
		# xanmod patches
		"${WORKDIR}"/patch-${PV}-xanmod${XANMOD_VERSION}
		# genpatches
		"${WORKDIR}/${PATCHSET}"/*.patch
	)
	default
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
