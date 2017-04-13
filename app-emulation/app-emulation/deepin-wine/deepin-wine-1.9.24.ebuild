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
	>=media-libs/alsa-lib-1.0.16
	>=media-libs/lcms-2.2
	>=net-nds/openldap-2.4.7
	>=media-sound/mpg123-1.13.7
	>=media-libs/openal-1.14
	>=net-libs/libpcap-0.9.8
	media-sound/pulseaudio
	media-libs/glu
	media-libs/mesa
	dev-libs/udis86
	sys-libs/zlib"

S=${WORKDIR}

src_install() {
	insinto /
	doins -r lib usr
	
	fperms 755 -R /usr/bin/
	fperms 755 -R /usr/lib/
}
