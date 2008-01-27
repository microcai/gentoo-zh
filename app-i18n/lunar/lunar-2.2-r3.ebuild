# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Chinese Lunar Calendar conversion utility"
HOMEPAGE="http://packages.debian.org/unstable/utils/lunar"
SRC_URI="mirror://debian/pool/main/l/${PN}/${PN}_${PV}.orig.tar.gz
	mirror://debian/pool/main/l/${PN}/${PN}_${PVR/r/}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch ../${PN}_${PVR/r/}.diff
}

src_install() {
	dobin lunar
	doman lunar.1
	dodir usr/share/lunar
	insinto /usr/share/lunar
	doins lunar.bitmap
}
