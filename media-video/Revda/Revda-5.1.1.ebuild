#Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

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
	net-libs/nodejs
"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
	)
	use dmlive || mycmakeargs+=( -DNODMLIVE=1 )
	cmake_src_configure
}
