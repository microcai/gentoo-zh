# Copyright 2021-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3 xdg

DESCRIPTION="Japanese SKK input engine for Fcitx5"
HOMEPAGE="https://fcitx-im.org/ https://github.com/fcitx/fcitx5-skk"
EGIT_REPO_URI="https://github.com/fcitx/fcitx5-skk"

LICENSE="GPL-3+"
SLOT="5"
IUSE="qt6"

RDEPEND="
	>=app-i18n/fcitx-5.1.13:5
	app-i18n/fcitx-qt[qt6?,-onlyplugin]
	app-i18n/libskk
	app-i18n/skk-jisyo
	qt6? (
		dev-qt/qtbase:6[dbus,gui,widgets]
	)
"
DEPEND="${RDEPEND}"
BDEPEND="
	kde-frameworks/extra-cmake-modules:0
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=( )
	if use qt6; then
		mycmakeargs+=(
			-DENABLE_QT=ON
		)
	fi
	cmake_src_configure
}
