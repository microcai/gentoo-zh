# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

DESCRIPTION="百毒歌曲批量下"
HOMEPAGE="http://code.google.com/p/yangyanggnu"
SRC_URI="https://yangyanggnu.googlecode.com/files/${PN}_v${PV}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="net-misc/curl[ssl]"
RDEPEND="${DEPEND}"

S="${WORKDIR}/biabiamiamia_v${PV}"

src_install(){
	cd ${BUILD_DIR}
	dodir /usr/bin
	install biabiamiamia ${D}/usr/bin
}
