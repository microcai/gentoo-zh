# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit toolchain-funcs git-2

DESCRIPTION="android debug bridge"
HOMEPAGE="android.googlesource.com"

EGIT_REPO_URI="http://android.googlesource.com/platform/system/core.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="sys-libs/zlib
	dev-libs/openssl"
RDEPEND="${DEPEND}"

src_compile(){
	cd adb
	cp ${FILESDIR}/Makefile Makefile	
	emake
}

src_install(){
	cd adb
	einstall DESTDIR=${D}
}
