# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils
DESCRIPTION="Deepin Movie Player"
HOMEPAGE="https://github.com/linuxdeepin/deepin-movie-reborn"
if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/linuxdeepin/${PN}.git"
	EGIT_BRANCH="vpu"
else
    SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-qt/qtdbus:5
		dev-qt/qtwidgets:5
		dev-qt/linguist-tools:5
		dev-qt/qtsvg:5
		dev-qt/qtmultimedia:5
		dev-qt/qtx11extras:5
		dde-base/dtksettings
		dde-base/deepin-tool-kit
		media-video/mpv[libmpv]
		x11-libs/libxcb
		x11-libs/xcb-util
		x11-libs/xcb-util-wm
		x11-proto/xcb-proto
		x11-proto/recordproto
		media-video/ffmpegthumbnailer
		x11-libs/libXtst
		media-sound/pulseaudio
		media-video/ffmpeg
		"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i "s|p->property|(*p)->property|g" src/common/actions.cpp
	sed -i "s|deepin-movie|deepin-movie-reborn|g" src/CMakeLists.txt
	default_src_prepare
}
