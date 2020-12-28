# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit eutils

DESCRIPTION="A Tutorial and Presentation creation software, primarily aimed at creating tutorials on how to use software"
HOMEPAGE="http://www.debugmode.com/wink/"
SRC_URI="http://dl9.afterdawn.com/download/29cd08e08dca1d685657a7bbae8ddda2/5030af09/n-z/wink15_b1060.tar.gz -> wink15.tar.gz"

RESTRICT="strip"

KEYWORDS="~x86"
SLOT="0"
LICENSE="FREEWARE"
IUSE=""

RDEPEND=" >=x11-libs/gtk+-2.4:2[abi_x86_32]
		|| ( sys-libs/libstdc++-v3 sys-libs/libstdc++-v3-bin )
			>=dev-libs/expat-2.0
		"

src_unpack(){
	unpack wink15.tar.gz
	mkdir -p $S
}

src_prepare() {
	tar -xvf "${WORKDIR}/installdata.tar.gz" -C "$S"
}

src_install() {
	dodir /opt/bin
	exeinto /opt/bin
	newexe ${FILESDIR}/wink.sh wink

	cp -a "${S}" ${D}/opt/wink

	# add libexpact.so.0 
	if use amd64 ; then
		dosym	/usr/lib32/libexpat.so.1 /opt/wink/libexpat.so.0
	elif use x86 ; then
		dosym	/usr/lib/libexpat.so.1 /opt/wink/libexpat.so.0
	fi
}
