# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit toolchain-funcs git-2

DESCRIPTION="fastboot is a util to control android bootloader"
HOMEPAGE="android.googlesource.com"

EGIT_ANDROID="http://android.googlesource.com/platform"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="sys-libs/zlib"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}/${PN}"

src_unpack() {
	# EGIT_COMMIT="48a6d3de590714f4e913c6cc3135a455126df91d"
	EGIT_REPO_URI="${EGIT_ANDROID}"/system/core \
	EGIT_SOURCEDIR="${WORKDIR}/${P}" \
	git-2_src_unpack

	# EGIT_COMMIT="144d160d4d21e70472fcc6a725ceb2358c1de3fc"
	EGIT_REPO_URI="${EGIT_ANDROID}"/system/extras \
	EGIT_SOURCEDIR=${S}/extras \
	git-2_src_unpack

	# EGIT_COMMIT="9ea93f235aec7f0075b3d8f5b2aec9ead0130e2e"
	EGIT_REPO_URI="${EGIT_ANDROID}"/external/libselinux \
	EGIT_SOURCEDIR=${S}/libselinux \
	git-2_src_unpack
}

src_prepare() {
	cp ${FILESDIR}/Makefile Makefile || die
	epatch ${FILESDIR}/${PN}-gcc-4.8.patch

	epatch_user
}
