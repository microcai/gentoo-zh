# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5


DESCRIPTION="Go-lang bingdings for dde-daemon"
HOMEPAGE="https://github.com/linuxdeepin/dde-api"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-devel/gcc[go]
		x11-wm/deepin-metacity
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
		"

DEPEND="${RDEPEND}
	      dev-go/go-dbus-generator
	      dev-go/deepin-go-lib
		  dev-go/go-gir-generator
	      dev-go/dbus-factory"

src_prepare() {
	  export GOPATH="${S}:/usr/share/gocode"
}

src_install() {
	  emake DESTDIR=${D} SYSTEMD_LIB_DIR=/usr/lib install
}
