# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Livestation is the new and interactive way to enjoy live TV and radio over broadband"
HOMEPAGE="http://www.livestation.com/"
SRC_URI="http://llstatic.livestation.com/releases/${P/l/L}.run"

LICENSE="LivestationEULA"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}
Ddir="/opt/${PN}"
RESTRICT="mirror strip"

QA_TEXTRELS="
${Ddir:1}/lib/libavutil.so.49
${Ddir:1}/lib/libavformat.so.52
${Ddir:1}/lib/libavcodec.so.51"

pkg_setup() {
	check_license "$(dirname ${EBUILD})/../../licenses/${LICENSE}"
}

src_unpack() {
	unpack_makeself ${A}
	rm  "${S}/i386/Livestation"
}

src_install() {
	dodir "${Ddir}"
	mv "${S}"/i386/* "${D}/${Ddir}"
	make_wrapper "${PN}" ./${PN/l/L}.bin "${Ddir}" "${Ddir}/lib"

	#TODO: introduce a menu entry for livestation
	#doicon livestation.xxx
	#make_desktop_entry something goes here.
}
