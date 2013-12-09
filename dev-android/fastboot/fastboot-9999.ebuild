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
	EGIT_REPO_URI="${EGIT_ANDROID}"/system/core
	EGIT_SOURCEDIR="${WORKDIR}/${P}" \
	git-2_src_unpack

	EGIT_REPO_URI="${EGIT_ANDROID}"/system/core
	EGIT_SOURCEDIR=${S}/extras \
	git-2_src_unpack

	EGIT_REPO_URI="${EGIT_ANDROID}"/system/core
	EGIT_SOURCEDIR=${S}/libselinux \
	git-2_src_unpack
}

src_prepare() {
	cp ${FILESDIR}/Makefile Makefile || die
}

src_install(){
	einstall DESTDIR=${D}
}
