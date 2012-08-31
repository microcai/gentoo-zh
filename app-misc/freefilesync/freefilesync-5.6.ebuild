# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

MY_P="FreeFileSync"

DESCRIPTION="Visual folder comparison and synchronization"
HOMEPAGE=""
SRC_URI="mirror://sourceforge/${PN}/${MY_P}_${PV}_source.zip"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="x11-libs/wxGTK
	dev-libs/boost
	x11-libs/gtk+:2"

RDEPEND="${DEPEND}"

S="${WORKDIR}"
