# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6


DESCRIPTION="Go-lang bingdings for dde-daemon"
HOMEPAGE="https://github.com/linuxdeepin/dde-api"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-devel/gcc[go]
		x11-libs/libXi
		dev-libs/glib:2
		x11-libs/gtk+:3
		x11-libs/gdk-pixbuf:2
		media-libs/libcanberra[pulseaudio]
		x11-libs/libXfixes
		net-wireless/rfkill
		app-text/poppler[cairo]
		x11-libs/libXcursor
		x11-apps/xcur2png
		gnome-base/librsvg:2
		media-gfx/blur-effect
		"

DEPEND="${RDEPEND}
	      dev-go/go-dbus-generator
	      >=dev-go/deepin-go-lib-1.1.0
		  dev-go/go-gir-generator
	      >=dev-go/dbus-factory-3.1.5"

src_prepare() {
	export GOPATH="${S}:/usr/share/gocode"
	default_src_prepare
}

#src_compile() {
#	emake USE_GCCGO=1
#}


src_install() {
	emake DESTDIR=${D} libdir=/$(get_libdir) SYSTEMD_LIB_DIR=/usr/$(get_libdir) install
}
