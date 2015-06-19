# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="AMI AFULNX Flasher - Linux based AMI BIOS Firmware Update flasher"
HOMEPAGE="https://www.wimsbios.com/amiflasher.jsp"
SRC_URI="https://www.wimsbios.com/files/flashers/ami/afulnx/${P}.zip"

LICENSE="AS-IS"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""
S="${WORKDIR}"
DEPEND=""
RDEPEND="${DEPEND}"

src_install(){
    if use amd64 ; then
	dodir /opt/afulnx64
	exeinto /opt/afulnx64
	insinto /opt/afulnx64
	doexe afulnx64/afulnx_64
	doins afulnx64/AFULNX.txt
	doins afulnx64/readme.txt
	doins afulnx64/readme_afulnx.txt	
	dosym ../afulnx64/afulnx_64 /opt/bin/afulnx_64
    elif use x86 ; then
	dodir /opt/afulnx32
	exeinto /opt/afulnx32
	insinto /opt/afulnx32
	doexe afulnx32/afulnx_32
	doins afulnx32/AFULNX.txt
	doins afulnx32/readme.txt
	doins afulnx32/readme_afulnx.txt	
	dosym ../afulnx64/afulnx_32 /opt/bin/afulnx_32
    fi
}

