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
IUSE="dtk1"

DEPEND="dev-qt/qtdbus:5
		dev-qt/qtwidgets:5
		dev-qt/linguist-tools:5
		dev-qt/qtsvg:5
		dev-qt/qtmultimedia:5
		dev-qt/qtx11extras:5
		dev-libs/openssl
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
		!media-video/deepin-movie
		"
RDEPEND="${DEPEND}
		>=dde-base/dtkcore-0.3.4
		!dtk1? ( >=dde-base/dtkwidget-0.3.3 )
		dtk1? ( <=dde-base/deepin-tool-kit-0.3.3 )
		"

src_prepare() {
	sed -i "s|p->property|(*p)->property|g" src/common/actions.cpp
	#sed -i "s|deepin-movie|deepin-movie-reborn|g" src/CMakeLists.txt
	use dtk1 && sed -i "s|IMPORTED_TARGET\ dtkwidget|IMPORTED_TARGET\ dtkwidget\ dtksettings\ dtksettingsview\ dtkcore|g" src/CMakeLists.txt
	default_src_prepare
}
