# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

MY_PN="${PN/-bin/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A multi thread download tool liked flashget based wxGTK"
HOMEPAGE="http://sourceforge.net/projects/multiget"
SRC_URI="mirror://sourceforge/multiget/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="
	!net-misc/multiget
	x11-libs/wxGTK"

S=${WORKDIR}
RESTRICT="primaryuri"

QA_PRESTRIPPED="usr/bin/${MY_PN}"

src_install() {
	dobin ${MY_PN}
	domenu "${FILESDIR}"/multiget.desktop
	doicon "${FILESDIR}"/multiget.png
}
