#Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Cute and useful Live Stream Player with danmaku support"
HOMEPAGE="https://github.com/THMonster/Revda"
SRC_URI="https://github.com/THMonster/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"

IUSE="+dmlive"

LICENSE="GPL-2"
SLOT="0"

BDEPEND="
	dev-util/cmake
	sys-apps/yarn
	kde-frameworks/extra-cmake-modules
	virtual/rust
"
RDEPEND="
	media-video/mpv
	media-video/ffmpeg
	net-misc/curl
	net-libs/webkit-gtk
"

src_prepare() {
	default
	if use dmlive; then
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
		-DCMAKE_INSTALL_PREFIX=/usr
	)
	else
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
		-DCMAKE_INSTALL_PREFIX=/usr
		-DNODMLIVE=1
	)
	fi
	cmake_src_prepare
}

src_install() {
	cmake_src_install
}

pkg_postinst() {
	einfo
	einfo "You may need to install net-libs/nodejs to support Douyu live streams:"
	einfo "    emerge -av net-libs/nodejs"
	einfo
}
