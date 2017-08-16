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
IUSE="+mp3 +flac +ogg +aac +dtk1"

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
	dtk1? ( >=dde-base/deepin-tool-kit-0.3.4:=
			dde-base/dtksettings )
	!dtk1? ( >=dde-base/dtkwidget-0.3.3:= )
	"

src_prepare() {
    if use dtk1; then
        sed -i "s|dtkwidget|dtkwidget1|g" music-player/music-player.pro 
        sed -i "s|dtkwidget|dtkwidget1|g" music-player/build.pri
        sed -i "s|dtkwidget|dtkwidget1|g" vendor/src/build.pri 
    fi   
	LIBDIR=$(qt5_get_libdir)
	sed -i "s|/usr/lib|${LIBDIR}|g" plugin/netease-meta-search/netease-meta-search.pro libdmusic/libdmusic.pro
	
	eqmake5	PREFIX=/usr
}

src_install() {
	emake INSTALL_ROOT=${D} install
}
