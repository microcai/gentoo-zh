# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

DESCRIPTION="Maxthon for Linux"
HOMEPAGE="http://www.maxthon.cn"
	  
SRC_URI="
	amd64? (
		http://dl.maxthon.cn/linux/deb/packages/amd64/maxthon-browser-stable_${PV}_amd64.deb	
	)
	x86? (
		http://dl.maxthon.cn/linux/deb/packages/i386/maxthon-browser-stable_${PV}_i386.deb
	)
"		  
	
inherit multilib eutils  unpacker  gnome2-utils  fdo-mime 
LICENSE="Maxthon"  
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	app-arch/bzip2
	app-misc/ca-certificates
	dev-libs/atk
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/libgcrypt:11
	dev-libs/nspr
	dev-libs/nss
	gnome-base/gconf:2
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/freetype
	net-print/cups
	sys-apps/dbus
	sys-libs/libcap
	>=sys-devel/gcc-4.4.0[cxx]
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:2
	>=x11-libs/libX11-1.5.0
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	x11-libs/pango
	x11-libs/gtkhotkey
	x11-misc/xdg-utils"
DEPEND=""

RESTRICT="mirror strip"

S=${WORKDIR}

src_install() {
	MAXTHON_HOME="opt/maxthon"
	mv opt usr "${D}" || die
	cd "${D}" || die
	chmod u+s "${MAXTHON_HOME}/maxthon_sandbox"
	
	local size
	for size in 22 24 32 48 64 128 256 ; do
		newicon -s ${size} "${MAXTHON_HOME}/product_logo_${size}.png" ${PN}-browser.png
	done

	dosym "/usr/$(get_libdir)/libudev.so"  "${MAXTHON_HOME}/libudev.so.0"	
	domenu "${MAXTHON_HOME}"/${PN}.desktop
	
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
	
	elog
	elog "选词之后<Control><Shift>X 发现更多精彩~"
	elog
}