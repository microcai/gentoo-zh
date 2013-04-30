# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Tencent QQ for Linux by longine"
HOMEPAGE="http://www.longene.org/"
SRC_URI="http://www.longene.org/download/WineQQ2012-${PV}-Longene.deb"

LICENSE="Tencent"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="system-wine"

RDEPEND="amd64? (
		app-emulation/emul-linux-x86-gtklibs
        )
	system-wine? (
		>=app-emulation/wine-1.5.23[abi_x86_32,-abi_x86_x32,-abi_x86_64,fontconfig,mp3,truetype,X,nls,xml] 
		<=app-emulation/wine-1.5.26[abi_x86_32,-abi_x86_x32,-abi_x86_64,fontconfig,mp3,truetype,X,nls,xml] 
	)
	!amd64? ( x11-libs/gtk+:2 )
"

RESTRICT="mirror strip"

QA_PRESTRIPPED="opt/linuxqq/qq"

S=$WORKDIR

src_install() {
	tar xzvf data.tar.gz -C ${D}/	
	chmod 755 ${D}/opt
	chmod 755 ${D}/usr
	cp ${D}/opt/longene/qq2012/qq2012-test.desktop ${D}/usr/share/applications/
	if use system-wine ; then
	    cp -f ${FILESDIR}/qq2012.sh ${D}/opt/longene/qq2012/qq2012.sh
	    rm -rf ${D}/opt/longene/qq2012/wine
	fi
}

pkg_postinst() {
	elog
	elog "Some user reported that some fonts could not display."
	elog "It was a system environment related issue."
	elog "If you have that issue, check Issue #92 (https://github.com/microcai/gentoo-zh/issues/92) to find out possible solution."
	elog
}
