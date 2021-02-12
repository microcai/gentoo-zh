# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils toolchain-funcs

DESCRIPTION="Chinese Lunar Calendar conversion utility"
HOMEPAGE="http://packages.debian.org/unstable/utils/lunar"
SRC_URI="mirror://debian/pool/main/l/${PN}/${PN}_${PV}.orig.tar.gz
	mirror://debian/pool/main/l/${PN}/${PN}_${PVR/r4/3.1}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch ../"${PN}_${PVR/r4/3.1}".diff
}

src_compile() {
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} -o ${PN} ${PN}.c || die "compile failed"
}

src_install() {
	dobin lunar || die "dobin failed"
	doman lunar.1 || die "doman failed"
	insinto /usr/share/lunar
	doins lunar.bitmap || die "doins failed"
}
