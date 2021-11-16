# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker

DESCRIPTION="Deepin wine6 stable(AMD64)"
HOMEPAGE="https://www.deepin.org"

COMMON_URI="https://github.com/oatiz/lyraile-overlay/releases/download/tempfile"
SRC_URI="${COMMON_URI}/${PN}_${PV}-1_amd64.deb
		 ${COMMON_URI}/${PN}-i386_${PV}-1_i386.deb
		 ${COMMON_URI}/${PN}-amd64_${PV}-1_amd64.deb
"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	app-emulation/vkd3d[abi_x86_32]
	media-libs/openal[abi_x86_32]
	dev-libs/ocl-icd[abi_x86_32]
	sys-libs/ncurses[abi_x86_32]
	media-sound/mpg123[abi_x86_32]
	media-libs/mesa[abi_x86_32,osmesa]
	x11-libs/libXrandr[abi_x86_32]
	dev-libs/libxml2[abi_x86_32]
	x11-libs/libXi[abi_x86_32]
	x11-libs/libXext[abi_x86_32]
	x11-libs/libXcursor[abi_x86_32]
	x11-libs/libX11[abi_x86_32]
	virtual/libusb[abi_x86_32]
	net-libs/libpcap[abi_x86_32]
	net-nds/openldap[abi_x86_32]
	media-libs/libjpeg-turbo[abi_x86_32]
	media-libs/libgphoto2[abi_x86_32]
	media-libs/libcanberra[abi_x86_32]
	media-libs/lcms:2[abi_x86_32]
	media-libs/gst-plugins-base[abi_x86_32]
	media-libs/glu[abi_x86_32]
	sys-devel/gettext[abi_x86_32]
	media-libs/freetype:2[abi_x86_32]
	media-libs/fontconfig[abi_x86_32]
	media-libs/alsa-lib[abi_x86_32]
"

S=${WORKDIR}

src_install() {
	insinto /
	doins -r usr opt

	fperms 755 -R /usr/bin/
	fperms 755 -R /usr/share/doc/${PN}
	fperms 755 -R /opt/${PN}/
}
