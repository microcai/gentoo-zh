# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils  unpacker  gnome2-utils  fdo-mime 

DESCRIPTION="Yunio for Linux"
HOMEPAGE="https://www.yunio.com/"

SRC_URI="
	amd64? (
	https://static.yunio.com/download/${P}-generic-amd64.tgz
	)
	x86? (
	https://static.yunio.com/download/${P}-generic-i386.tgz
	)
"
	
LICENSE="Yunio"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="
	app-arch/bzip2
	dev-libs/expat
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libpng
	sys-apps/util-linux
	sys-devel/gcc
	sys-libs/glibc
	sys-libs/zlib
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXrender
	x11-libs/libxcb
"
DEPEND=""

S=$WORKDIR

src_install() {
	exeinto "/usr/bin"
	exeopts -m0755
	doexe "${S}/yunio"
	
	insinto "/usr/share/pixmaps"
	doins "${FILESDIR}/yunio.png"
	
	insinto "/usr/share/applications"
	doins "${FILESDIR}/yunio.desktop"
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
