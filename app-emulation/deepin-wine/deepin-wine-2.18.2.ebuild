# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit unpacker versionator

DESCRIPTION="Deepin Version of Wine"
HOMEPAGE="https://www.deepin.org"

COMMON_URI="http://packages.deepin.com/deepin/pool/non-free/d"
DWV=$(replace_version_separator 2 '-' )

SRC_URI="${COMMON_URI}/deepin-wine/deepin-fonts-wine_${DWV}_all.deb
	${COMMON_URI}/deepin-wine/deepin-libwine_${DWV}_i386.deb
	${COMMON_URI}/deepin-wine/deepin-wine32_${DWV}_i386.deb
	${COMMON_URI}/deepin-wine/deepin-wine_${DWV}_all.deb"


LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	>=media-libs/alsa-lib-1.0.16[abi_x86_32]
	>=media-libs/lcms-2.2[abi_x86_32]
	>=net-nds/openldap-2.4.7[abi_x86_32]
	>=media-sound/mpg123-1.13.7[abi_x86_32]
	>=media-libs/openal-1.14[abi_x86_32]
	virtual/opencl[abi_x86_32]
	>=net-libs/libpcap-0.9.8[abi_x86_32]
	media-sound/pulseaudio[abi_x86_32]
	media-libs/glu[abi_x86_32]
	media-libs/mesa[abi_x86_32]
	dev-libs/udis86[abi_x86_32]
	sys-libs/zlib[abi_x86_32]"

S=${WORKDIR}

src_install() {
	insinto /
	doins -r lib usr
	
	fperms 755 -R /usr/bin/
	fperms 755 -R /usr/lib/
}
