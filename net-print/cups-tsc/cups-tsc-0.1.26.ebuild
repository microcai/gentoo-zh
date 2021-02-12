# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs multilib

DESCRIPTION="The driver of TSC printers for Linux and CUPS"
HOMEPAGE="http://www.tscprinters.com/cms/theme/index-39.html"
SRC_URI="http://www.tscprinters.com/cms/upload/download_en/download_151TSC_Linux_32bit.zip.zip"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-print/cups
	app-text/ghostscript-gpl"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
}

src_configure() {
	return 0
}

src_prepare() {
	return 0
}

src_compile() {
	return 0
}

src_install () {

	insinto /usr/share/cups/model/
	doins "${WORKDIR}"/TSC_Linux_32/tscdriver-0.1.26/ppd/*

	exeinto /usr/libexec/cups/filter/
	doexe "${WORKDIR}"/TSC_Linux_32/tscdriver-0.1.26/pstotspl
	doexe "${WORKDIR}"/TSC_Linux_32/tscdriver-0.1.26/pstotspl2

	exeinto /usr/bin/
	doexe "${WORKDIR}"/TSC_Linux_32/tscdriver-0.1.26/thermalprinterui
	doexe "${WORKDIR}"/TSC_Linux_32/tscdriver-0.1.26/thermalprinterut
}
