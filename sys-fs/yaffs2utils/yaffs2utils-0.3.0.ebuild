# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Utilities to create/extract a yaffs2 image on Linux"
HOMEPAGE="https://code.google.com/p/yaffs2utils/"
SRC_URI="https://yaffs2utils.googlecode.com/files/latest.tar.gz"


LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S="${WORKDIR}/latest"

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare(){
	echo INSTALLDIR = ${D}/bin >> Makefile
}

src_compile(){
	emake
}

src_install(){
	dodir /bin
	einstall
}
