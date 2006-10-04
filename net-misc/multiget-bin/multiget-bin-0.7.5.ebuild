# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_PN="${PN/m/M}"
MY_PN="${MY_PN/g/G}"
MY_PN="${MY_PN/-bin/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A multi thread download tool liked flashget based wxGTK"
HOMEPAGE="http://sourceforge.net/projects/multiget"
SRC_URI="mirror://sourceforge/multiget/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="x11-libs/wxGTK !net-misc/multiget"
RDEPEND="${DEPEND}"

RESTRICT="primaryuri"

src_unpack() {
	cd ${WORKDIR}
	unpack ${MY_P}.tar.gz
}

src_install() {
	cd ${WORKDIR}
	dobin ${MY_PN}
	insinto /usr/share/applications
	doins ${FILESDIR}/multiget.desktop
	insinto /usr/share/pixmaps
	doins ${FILESDIR}/multiget.png
}
