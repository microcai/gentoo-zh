# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

DESCRIPTION="Deepin Version of Wine"
HOMEPAGE="https://www.deepin.org"

COMMON_URI="https://community-packages.deepin.com/deepin/pool/non-free/u"
SRC_URI="${COMMON_URI}/udis86/udis86_${PV}-${PR/r/}_i386.deb"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	"

S=${WORKDIR}

src_install() {
	insinto /usr
	doins -r usr/bin usr/include usr/lib

	fperms 0755 -R /usr/bin/
}
