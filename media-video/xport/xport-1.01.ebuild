# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="xport Transport Stream Demuxer"
HOMEPAGE="http://www.w6rz.net/"
SRC_URI="http://www.w6rz.net/xport.zip"

LICENSE=""
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}"

src_compile() {
	gcc $CFLAGS -o xporthdmv xport.c
}

src_install() {
	dobin xporthdmv
}
