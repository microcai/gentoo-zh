# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit unpacker versionator

DESCRIPTION="Deepin Version of Wine"
HOMEPAGE="https://www.deepin.org"

COMMON_URI="http://packages.deepin.com/deepin/pool/non-free/d"
MY_PV=$(replace_version_separator 2 'deepin' )

SRC_URI="${COMMON_URI}/deepin-wine-helper/deepin-wine-helper_${MY_PV}_i386.deb"


LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	app-emulation/deepin-wine
	app-arch/p7zip
	net-libs/gnutls
	media-libs/libv4l"

S=${WORKDIR}

src_install() {
	insinto /
	doins -r opt
	
	fperms 755 -R /opt/deepinwine/tools/
}
