# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="Qt5 binding of Chromium Embedded Framework"
HOMEPAGE="https://github.com/linuxdeepin/qcef"
CEF_COMMIT="059a0c9cef4e289a50dc7a2f4c91fe69db95035e"
SRC_URI="
  https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
  https://github.com/linuxdeepin/cef-binary/archive/${CEF_COMMIT}.zip -> cef-${CEF_COMMIT}.zip"
KEYWORDS="~amd64 ~x86"
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
		 app-arch/unzip
		"
DEPEND="${RDEPEND}
		virtual/pkgconfig
		"

src_prepare() {
	rm -rf cef
	ln -s ${WORKDIR}/cef-binary-${CEF_COMMIT} cef || die
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DQCEF_INSTALL_PATH=/usr/$(get_libdir)
	)
	cmake-utils_src_configure
}
