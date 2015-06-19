# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Tencent QQ for Linux by longine"
HOMEPAGE="http://www.longene.org/"
SRC_URI="http://www.longene.org/download/WineQQ2013SP6-${PV}-Longene.deb"

LICENSE="Tencent"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="system-wine"

RDEPEND="
	x11-libs/gtk+:2[abi_x86_32]

	system-wine? (
		>=app-emulation/wine-1.7.16[abi_x86_32,-abi_x86_x32,-abi_x86_64,fontconfig,mp3,truetype,X,nls,xml]
	)
"

RESTRICT="mirror strip"

QA_PRESTRIPPED="opt/linuxqq/qq"

S=$WORKDIR

src_install() {
	tar xzvf data.tar.gz -C ${D}/	

	chmod 755 ${D}/opt
	chmod 755 ${D}/usr
	chown -R root:root ${D}
	cp ${D}/opt/longene/qq/qq-test.desktop ${D}/usr/share/applications/
	if use system-wine ; then
		rm ${D}/opt/longene/qq/wine-lib/bin -rf
		ln -svf /usr/bin  ${D}/opt/longene/qq/wine-lib/bin
		rm -rf ${D}/opt/longene/qq/wine-lib/lib
	fi
}

pkg_postinst() {
	elog
	elog "Some user reported that some fonts could not display."
	elog "It was a system environment related issue."
	elog "If you have that issue, check Issue #92 (https://github.com/microcai/gentoo-zh/issues/92) to find out possible solution."
	elog
}
