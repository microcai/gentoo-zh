# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

inherit eutils

DESCRIPTION="Chinese HZ/GB/BIG5/UNI/UTF7/UTF8 encodings auto-converter"
HOMEPAGE="http://packages.debian.org/stable/text/zh-autoconvert.html"
SRC_URI="mirror://debian/pool/main/z/${PN}/${PN}_${PV}.orig.tar.gz
	mirror://debian/pool/main/z/${PN}/${PN}_${PVR/r/}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sh sparc x86"
IUSE=""

RESTRICT="mirror"

DEPEND="=x11-libs/gtk+-1.2.10-r12"

RDEPEND="${DEPEND}"

S=${WORKDIR}/${P/zh-}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch ../${PN}_${PVR/r/}.diff
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

