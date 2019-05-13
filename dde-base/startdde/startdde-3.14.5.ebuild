# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

EGO_PN="startdde"
EGO_VENDOR=(
"golang.org/x/net aaf60122140d3fcf75376d319f0554393160eb50 github.com/golang/net"
"github.com/cryptix/wav 8bdace674401f0bd3b63c65479b6a6ff1f9d5e44"
)

inherit golang-vcs-snapshot

DESCRIPTION="starter of Deepin Desktop Environment"
HOMEPAGE="https://github.com/linuxdeepin/startdde"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
		${EGO_VENDOR_URI}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dde-base/dde-daemon-3.1.17
		virtual/dde-wm
		>=dde-base/deepin-desktop-schemas-3.1.15
		"

DEPEND="${RDEPEND}
		gnome-base/libgnome-keyring
		dev-lang/coffee-script
		dev-go/go-dbus-generator
		>=dev-go/go-gir-generator-2.0.0
		dev-go/go-dbus-factory
		dev-util/cmake
		>=dde-base/dde-api-3.1.8
		>=dev-go/deepin-go-lib-1.1.0
		>=dev-go/dbus-factory-3.1.5"

src_prepare() {
	mkdir -p "${T}/golibdir/"
	cp -r  "${S}/src/${EGO_PN}/vendor"  "${T}/golibdir/src"
	export GOPATH="$(get_golibdir_gopath):${T}/golibdir/"

	LIBDIR=$(get_libdir)
	cd ${S}/src/${EGO_PN}
	sed -i "s|/lib/|/${LIBDIR}/|g" Makefile
	default_src_prepare
}

src_compile() {
	cd ${S}/src/${EGO_PN}
	emake
}

src_install() {
	cd ${S}/src/${EGO_PN}
	emake DESTDIR="${D}" install
}
