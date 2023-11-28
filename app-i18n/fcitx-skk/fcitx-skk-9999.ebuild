# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3 xdg

DESCRIPTION="Japanese SKK input engine for Fcitx5"
HOMEPAGE="https://fcitx-im.org/ https://github.com/fcitx/fcitx5-skk"
EGIT_REPO_URI="https://github.com/fcitx/fcitx5-skk"

LICENSE="GPL-3+"
SLOT="5"
IUSE="+qt5"

BDEPEND="
	kde-frameworks/extra-cmake-modules:0
	virtual/pkgconfig
"

RDEPEND="
	>=app-i18n/fcitx-5.1.5:5
	app-i18n/fcitx-qt[qt5,-onlyplugin]
	app-i18n/libskk
	app-i18n/skk-jisyo
"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_LIBDIR="${EPREFIX}/usr/$(get_libdir)"
		-DENABLE_QT="$(usex qt5)"
	)
	cmake_src_configure
}
