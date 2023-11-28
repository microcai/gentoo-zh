# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Input method development support for xcb"
HOMEPAGE="https://github.com/fcitx/xcb-imdkit"
SRC_URI="https://download.fcitx-im.org/fcitx5/${PN}/${P}.tar.xz"

LICENSE="LGPL-2.1 !system-uthash? ( BSD-1 )"
SLOT="5"
KEYWORDS="~amd64 ~arm64 ~loong ~riscv ~x86"
IUSE="+system-uthash"

RDEPEND="
	x11-libs/libxcb
	x11-libs/xcb-util
	x11-libs/xcb-util-keysyms
"
DEPEND="${RDEPEND}"
BDEPEND="
	kde-frameworks/extra-cmake-modules:0
	virtual/pkgconfig
	system-uthash? ( dev-libs/uthash )
"

src_configure() {
	local mycmakeargs=(
		-DUSE_SYSTEM_UTHASH=$(usex system-uthash ON OFF)
	)
	cmake_src_configure
}
