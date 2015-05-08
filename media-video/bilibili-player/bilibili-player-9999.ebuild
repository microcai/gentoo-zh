# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils git-r3

DESCRIPTION="bilibili 弹幕播放器 for Linux"
HOMEPAGE="https://github.com/microcai/bilibili_player"
#SRC_URI="https://codeload.github.com/microcai/bilibili_player/tar.gz/v${PV} -> ${P}.tar.gz"

EGIT_REPO_URI="https://github.com/microcai/bilibili_player.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="+vaapi +vdpau -alsa +pulseaudio"

DEPEND=">=dev-qt/qtmultimedia-5.4[widgets,pulseaudio=,alsa=]
	>=dev-qt/qtxml-5.4
	>=dev-qt/qtdbus-5.4
	>=dev-qt/qtnetwork-5.4
	>=dev-qt/qtwidgets-5.4
	>=dev-qt/qtx11extras-5.4
	>=dev-qt/qtgui-5.4[opengl]
	>=dev-qt/qtsvg-5.4
	>=dev-libs/boost-1.55[threads(+),context]
	sci-physics/bullet
	media-libs/libass
	x11-libs/libXrandr
	media-video/ffmpeg[x264,aac,aacplus,mp3,network,threads,zlib,opengl,vaapi=,vdpau=]
"

RDEPEND="${DEPEND}"

DEPEND="${DEPEND}
	virtual/pkgconfig
	dev-util/cmake
"

# S="${WORKDIR}/bilibili_player-${PV}"

RESTRICT="mirror"
