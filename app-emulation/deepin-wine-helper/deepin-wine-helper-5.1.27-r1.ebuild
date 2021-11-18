# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

DESCRIPTION="Deepin Wine Helper"
HOMEPAGE="https://www.deepin.org"

COMMON_URI="https://home-store-packages.uniontech.com/appstore/pool/appstore/d"
SRC_URI="${COMMON_URI}/${PN}/${PN}_${PV}-${PR/r/}_i386.deb"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	app-emulation/deepin-wine-plugin[virtual-pkg]"

S=${WORKDIR}

src_install() {
	insinto /
	doins -r opt

	fperms 755 -R /opt/deepinwine/tools/
}
