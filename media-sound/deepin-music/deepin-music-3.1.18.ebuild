# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

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
	>=dde-base/dtkwidget-2.0.0:=
	"

src_prepare() {
	eapply_user
	LIBDIR=$(qt5_get_libdir)
	sed -i "s|\$\${PREFIX}/lib|${LIBDIR}|g" src/vendor/mpris-qt/src/src.pro src/vendor/dbusextended-qt/src/src.pro src/plugin/netease-meta-search/netease-meta-search.pro src/libdmusic/libdmusic.pro

	export QT_SELECT=qt5
	eqmake5 PREFIX=/usr
}

src_install() {
	emake INSTALL_ROOT=${D} install
}
