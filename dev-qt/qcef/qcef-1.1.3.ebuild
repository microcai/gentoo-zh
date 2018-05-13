# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils

DESCRIPTION="Qt5 binding of Chromium Embedded Framework"
HOMEPAGE="https://github.com/linuxdeepin/qcef"

if [[ "${PV}" == *9999* ]] ; then
     inherit git-r3
     EGIT_REPO_URI="https://github.com/linuxdeepin/${PN}.git"
else
     SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	 KEYWORDS="~amd64 ~x86"
fi
LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="dev-qt/qtwebchannel:5
		 dev-qt/qtx11extras:5
		 dev-qt/qtcore:5
		 dev-qt/qtdbus:5
		 dev-qt/qtgui:5
		 dev-qt/qtnetwork:5
		 dev-qt/qtwidgets:5
		 dev-qt/linguist-tools:5
		 x11-libs/libXext
		 x11-libs/libX11
		 x11-libs/libXtst
		 x11-libs/libXScrnSaver
		 x11-libs/gtk+:2
		 media-libs/fontconfig
		 media-libs/harfbuzz
		 media-libs/alsa-lib
		 media-libs/mesa
		 dev-libs/glib
		 dev-libs/nspr
		 dev-libs/nss
		 media-sound/pulseaudio
		 sys-devel/flex
		 gnome-base/gconf
		"
DEPEND="${RDEPEND}
		virtual/pkgconfig
		"

src_configure() {
	local mycmakeargs=(
		-DQCEF_INSTALL_PATH=/usr/$(get_libdir)
	)
	cmake-utils_src_configure
}
