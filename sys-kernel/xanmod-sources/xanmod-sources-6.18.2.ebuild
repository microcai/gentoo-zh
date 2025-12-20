# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
ETYPE="sources"
K_WANT_GENPATCHES="base extras"
#Note: to bump xanmod, check K_GENPATCHES_VER in sys-kernel/gentoo-sources
K_GENPATCHES_VER="3"

inherit check-reqs kernel-2
detect_version
detect_arch

MY_P=linux-${PV%.*}
DESCRIPTION="Full XanMod source, including the Gentoo patchset and other patch options."
HOMEPAGE="https://xanmod.org"

XANMOD_VERSION="1"
XANMOD_URI="https://master.dl.sourceforge.net/project/xanmod/releases/main"
OKV="${OKV}-xanmod"
SRC_URI="
	${KERNEL_BASE_URI}/linux-${KV_MAJOR}.${KV_MINOR}.tar.xz
	${GENPATCHES_URI}
	https://phoenixnap.dl.sourceforge.net/project/xanmod/releases/main/${PV}-xanmod1/patch-${PV}-xanmod1.xz
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
	# delete linux version patches
	rm "${WORKDIR}"/*${MY_P}*.patch
	# delete failed patches
	rm "${WORKDIR}/1710_disable_sse4a.patch"

	local PATCHES=(
		# xanmod patches
		"${WORKDIR}"/patch-${PV}-xanmod${XANMOD_VERSION}
		# genpatches
		"${WORKDIR}"/*.patch
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
