# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4


inherit toolchain-funcs git-2

DESCRIPTION="fastboot is a util to control android bootloader"
HOMEPAGE=""
SRC_URI=""

EGIT_REPO_URI="https://android.googlesource.com/platform/system/core.git"


LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="sys-libs/zlib"
RDEPEND="${DEPEND}"


src_compile(){
	cd fastboot
	cp ${FILESDIR}/Makefile Makefile	
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" LD="$(tc-getLD)"
}

src_install(){
	cd fastboot
	einstall DESTDIR=${D}
}
