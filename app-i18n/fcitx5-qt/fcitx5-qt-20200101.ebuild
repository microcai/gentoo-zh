# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit cmake-utils git-r3
EGIT_REPO_URI="https://github.com/fcitx/fcitx5-qt.git"
if [[ ! "${PV}" =~ (^|\.)9999$ ]]; then
	EGIT_COMMIT="3732581153058a333d3f840f4fcdd54457d52865"
fi


SRC_URI=""

DESCRIPTION="Qt library and IM module for fcitx5"
HOMEPAGE="https://github.com/fcitx/fcitx5-qt"

LICENSE="BSD-1 GPL-2+ LGPL-2+ MIT"
SLOT="5"
KEYWORDS="~amd64"
IUSE="qt5 only_plugin"

RDEPEND="app-i18n/fcitx5
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	dev-qt/qtconcurrent:5
	kde-frameworks/extra-cmake-modules"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DLIB_INSTALL_DIR="${EPREFIX}/usr/$(get_libdir)"
		-DSYSCONFDIR="${EPREFIX}/etc"
		-DCMAKE_INSTALL_LIBDIR="${EPREFIX}/usr/$(get_libdir)"
		-DCMAKE_BUILD_TYPE=Release
		-DENABLE_QT4=no
		-DENABLE_QT5=$(usex qt5)
		-DONLY_PLUGIN=$(usex only_plugin)
	)
	cmake-utils_src_configure
}

src_install(){
	cmake-utils_src_install
}
