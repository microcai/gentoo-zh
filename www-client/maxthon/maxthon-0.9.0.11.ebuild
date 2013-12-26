# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

DESCRIPTION="Maxthon for Linux"
HOMEPAGE="http://www.maxthon.cn"
SRC_URI="amd64? ( http://dl.maxthon.cn/mx_linux/package/maxthon_${PV}_amd64_cn.deb )
	x86? ( http://dl.maxthon.cn/mx_linux/package/maxthon_${PV}_i386_cn.deb )"

inherit multilib eutils  unpacker  gnome2-utils  fdo-mime 
LICENSE="Maxthon"  
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	sys-fs/e2fsprogs
	dev-libs/atk
	app-arch/bzip2
	x11-libs/cairo
	sys-apps/dbus
	dev-libs/dbus-glib
	gnome-base/gconf
	sys-libs/glibc
	dev-libs/gmp
	net-libs/gnutls
	media-gfx/graphite2
	media-libs/harfbuzz
	dev-libs/libffi
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
	x11-misc/xdg-utils"
DEPEND=""

S=${WORKDIR}

src_install() {
	MAXTHON_HOME="opt/maxthon"
	mv opt usr "${D}" || die
	cd "${D}" || die
	rm "${MAXTHON_HOME}/Default/zh"
	chmod u+s "${MAXTHON_HOME}/maxthon_sandbox"

	domenu "${MAXTHON_HOME}"/${PN}-browser.desktop
	local size
	for size in 22 24 32 48 64 128 256 ; do
		newicon -s ${size} "${MAXTHON_HOME}/product_logo_${size}.png" ${PN}-browser.png
	done

	dosym "/usr/$(get_libdir)/libudev.so"  "${MAXTHON_HOME}/libudev.so.0"	
}
pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
	elog "如果flash显示不正常 请尝试修改启动命令 maxthon --ppapi-flash-path=/opt/google/chrome/PepperFlash/libpepflashplayer.so"
}
