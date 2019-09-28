# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

EGO_PN="pkg.deepin.io/dde/api"
EGO_VENDOR=(
"golang.org/x/image f315e440302883054d0c2bd85486878cb4f8572c github.com/golang/image"
"golang.org/x/net aaf60122140d3fcf75376d319f0554393160eb50 github.com/golang/net"
"gopkg.in/alecthomas/kingpin.v2 947dcec5ba9c011838740e680966fd7087a71d0d github.com/alecthomas/kingpin"
"github.com/alecthomas/units 2efee857e7cfd4f3d0138cc3cbb1b4966962b93a"
"github.com/alecthomas/template a0175ee3bccc567396460bf5acd36800cb10c49c"
"github.com/cryptix/wav 8bdace674401f0bd3b63c65479b6a6ff1f9d5e44"
"github.com/fogleman/gg 0403632d5b905943a1c2a5b2763aaecd568467ec"
"github.com/golang/freetype e2365dfdc4a05e4b8299a783240d4a7d5a65d4e4"
"github.com/disintegration/imaging 5362c131d56305ce787e79a5b94ffc956df00d62"
"github.com/nfnt/resize 83c6a9932646f83e3267f353373d47347b6036b2"
)

inherit golang-vcs-snapshot golang-build mount-boot

DESCRIPTION="Go-lang bingdings for dde-daemon"
HOMEPAGE="https://github.com/linuxdeepin/dde-api"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
${EGO_VENDOR_URI}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/libXi
		dev-libs/glib:2
		x11-libs/gtk+:3
		x11-libs/gdk-pixbuf:2
		media-libs/libcanberra[pulseaudio]
		x11-libs/libXfixes
		|| ( net-wireless/rfkill
		>=sys-apps/util-linux-2.31 )
		app-text/poppler[cairo]
		x11-libs/libXcursor
		x11-apps/xcur2png
		gnome-base/librsvg:2
		media-gfx/blur-effect
		"

DEPEND="${RDEPEND}
		dev-go/go-dbus-generator
		>=dev-go/deepin-go-lib-1.9.2
		>=dev-go/go-gir-generator-2.0.0
		dev-go/go-dbus-factory
		dev-go/go-x11-client
		>=dev-go/dbus-factory-3.1.5"

src_compile() {
	mkdir -p "${T}/golibdir/"
	cp -r  "${S}/src/${EGO_PN}/vendor"  "${T}/golibdir/src"

	export GOPATH="${S}:$(get_golibdir_gopath):${T}/golibdir/" 
	cd ${S}/src/${EGO_PN}
	emake
}


src_install() {
	cd ${S}/src/${EGO_PN}
	emake DESTDIR=${D} libdir=/$(get_libdir) SYSTEMD_LIB_DIR=/$(get_libdir) GOSITE_DIR=$(get_golibdir_gopath) install
}
