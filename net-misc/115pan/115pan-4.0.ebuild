# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils  unpacker  gnome2-utils  fdo-mime 

DESCRIPTION="115pan for Linux"
HOMEPAGE="http://pc.115.com/linux.html"

SRC_URI="http://pc.115.com/download/linux/115wangpan_linux_v${PV}.deb"
	
LICENSE=" "
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="
	x86? (
		sys-libs/glibc
		sys-devel/gcc
	)
	amd64? (
		app-emulation/emul-linux-x86-xlibs
		sys-devel/gcc[multilib]
		sys-libs/glibc[multilib]
	)		
	x11-libs/libXau	
"
DEPEND=""

S=$WORKDIR

src_install() {
	exeinto "/usr/bin"
	exeopts -m0755
	doexe "${S}/usr/bin/115pan"
	
	insinto "/usr/share/pixmaps"
	doins "${S}/usr/share/pixmaps/115pan.png"
	
	insinto "/usr/share/applications"
	doins "${S}/usr/share/applications/115pan.desktop"
	
	insinto "/usr/bin"
	doins "${FILESDIR}/qt.conf"
	
	insinto "/usr/share/fonts/115/lib/fonts/"
	doins "${S}/lib/fonts/msyh.ttf"
		
	domenu usr/share/applications/115pan.desktop	
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
