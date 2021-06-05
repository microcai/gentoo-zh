# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Input method development support for xcb"
HOMEPAGE="https://github.com/fcitx/xcb-imdkit"
SRC_URI="https://github.com/fcitx/xcb-imdkit/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="
	MIT
	LGPL-2.1+
	!system-uthash? ( BSD-1 )
"
SLOT="5"
KEYWORDS="~amd64 ~x86"
IUSE="+system-uthash"

RDEPEND="
	x11-libs/libxcb
	x11-libs/xcb-util
	x11-libs/xcb-util-keysyms
"
DEPEND="
	${RDEPEND}
	kde-frameworks/extra-cmake-modules:5
	system-uthash? ( dev-libs/uthash )
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=(
		-DUSE_SYSTEM_UTHASH=$(usex system-uthash ON OFF)
	)
	cmake_src_configure
}
