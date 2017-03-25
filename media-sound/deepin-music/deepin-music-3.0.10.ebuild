# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit qmake-utils

DESCRIPTION="Deepin Music Player"
HOMEPAGE="https://github.com/linuxdeepin/deepin-music"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="3"
KEYWORDS="~amd64 ~x86"
IUSE="+mp3 +flac +ogg +aac"

RDEPEND="dev-qt/qtmultimedia:5[gstreamer]
	dev-libs/icu
	dev-qt/qtsvg:5
	dev-qt/qtconcurrent:5
	>dde-base/deepin-menu-2.90.1
	sys-devel/bison
	media-libs/libcue
	media-video/ffmpeg
	>=media-libs/taglib-1.10
	media-plugins/gst-plugins-meta:1.0[mp3=,flac=,ogg=,aac=]
	"
DEPEND="${RDEPEND}
	>=dde-base/deepin-tool-kit-0.2.0:=
	dde-base/dtksettings
	"

src_prepare() {
	LIBDIR=$(qt5_get_libdir)
	sed -i "s|/usr/lib|${LIBDIR}|g" plugin/netease-meta-search/netease-meta-search.pro libdmusic/libdmusic.pro
	
	sed -i "s|-0-2||g" music-player/music-player.pro
	eqmake5	PREFIX=/usr
}

src_install() {
	emake INSTALL_ROOT=${D} install
}
