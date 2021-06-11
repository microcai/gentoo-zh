# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="1"
K_SECURITY_UNSUPPORTED="1"
K_NOSETEXTRAVERSION="1"
ETYPE="sources"
DEPEND="app-arch/cpio
dev-util/pahole
dev-libs/libbpf
"
RDEPEND="
	!sys-kernel/xanmod-sources
	!sys-kernel/xanmod-hybrid
"

inherit kernel-2-src-prepare-overlay
detect_version

DESCRIPTION="Xanmod-Cacule patchset for main kernel tree"
HOMEPAGE="https://xanmod.org/"
LICENSE+=" CDDL"
SRC_URI="
	${KERNEL_BASE_URI}/linux-5.12.tar.xz
	https://github.com/xanmod/linux/releases/download/5.12.10-xanmod1-cacule/patch-5.12.10-xanmod1-cacule.xz
	https://github.com/HougeLangley/customkernel/releases/download/v5.12-others/v1-cjktty.patch
	https://github.com/HougeLangley/customkernel/releases/download/v5.12-others/v1-uksm.patch
	${GENPATCHES_URI}
"

UNIPATCH_LIST_DEFAULT="${DISTDIR}/patch-5.12.10-xanmod1-cacule.xz ${DISTDIR}/v1-cjktty.patch ${DISTDIR}/v1-uksm.patch"

KEYWORDS="~amd64"

pkg_postinst() {
	elog "MICROCODES"
	elog "Use xanmod-sources with microcodes"
	elog "Read https://wiki.gentoo.org/wiki/Intel_microcode"
}
