# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Chinese HZ/GB/BIG5/UNI/UTF7/UTF8 encodings auto-converter"
HOMEPAGE="http://packages.debian.org/stable/text/zh-autoconvert.html"
SRC_URI="mirror://debian/pool/main/z/${PN}/${PN}_${PV}.orig.tar.gz
	mirror://debian/pool/main/z/${PN}/${PN}_${PV}-1.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

S=${WORKDIR}/${P/zh-}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch ../${PN}_${PV}-1.diff
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	dobin autogb 
	dosym autogb /usr/bin/autob5

	dolib.a lib/libhz.a
	dolib.so lib/libhz.so.0.0 
	dosym libhz.so.0.0 /usr/lib/libhz.so.0
	dosym libhz.so.0 /usr/lib/libhz.so

	exeinto /usr/lib/xchat/plugins/
	doexe contrib/xchat-plugins/xchat-autogb.so
	doexe contrib/xchat-plugins/xchat-autob5.so

	insinto /usr/include
	doins include/*.h
}

