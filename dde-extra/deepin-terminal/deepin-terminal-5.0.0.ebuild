# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

VALA_MIN_API_VERSION=0.22

inherit vala cmake-utils

DESCRIPTION="Deepin Terminal"
HOMEPAGE="https://github.com/linuxdeepin/deepin-terminal"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+zssh"

RDEPEND="
	>=dev-libs/glib-2.32:2
	dev-libs/libgee:0.8
	>=x11-libs/gtk+-3.4:3
	app-crypt/libsecret[vala]
	x11-libs/libwnck:3
	dde-base/deepin-menu
	dev-tcltk/expect
	dev-libs/json-glib
	>=x11-libs/vte-0.50.1:2.91[vala]
	zssh? ( net-misc/zssh )
	"
DEPEND="${RDEPEND}
	$(vala_depend)
	gnome-base/librsvg:2[vala]
	dev-util/gperf
	dev-libs/gobject-introspection
	"

src_prepare() {
	vala_src_prepare
	sed -i -e "/NAMES/s:valac:${VALAC}:" cmake/FindVala.cmake || die 
	sed -i "s|lib/\${target}|$(get_libdir)/\${target}|g" CMakeLists.txt

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		VALAC="${VALAC}"
		-DTEST_BUILD=0
		-DCMAKE_INSTALL_PREFIX=/usr
		-DCMAKE_BUILD_TYPE=Release
		-DUSE_VENDOR_LIB=0
		-DVERSION=${PV}
	)
	cmake-utils_src_configure
}

