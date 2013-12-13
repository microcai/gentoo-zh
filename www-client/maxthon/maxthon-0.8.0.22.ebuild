# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

DESCRIPTION="Maxthon for Linux"
HOMEPAGE="http://www.maxthon.cn"
SRC_URI="amd64? ( http://dl.maxthon.cn/mx_linux/package/maxthon_${PV}_amd64_cn.deb )
	x86? ( http://dl.maxthon.cn/mx_linux/package/maxthon_${PV}_i386.deb )"


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
	tar xzvf data.tar.gz -C ${D}/
	chmod 755 ${D}/opt
	chmod 755 ${D}/usr
	doexe ${D}/opt/maxthon/config-after-install.sh	
}
pkg_postinst() {
	elog
	elog "A browser that combines a minimal design with sophisticated technology to make the web faster, safer, and easier."
	elog "TIPS：本版本需要验证激活才能测试，你可以加傲游Linux版体验群：304417046，加群时请注明：傲游Linux版。"
	elog "可以用shared@china激活,请不要外传"
	elog
}
