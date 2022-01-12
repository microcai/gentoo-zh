# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg cmake

DESCRIPTION="Japanese Kana Kanji conversion engine for Fcitx5"
HOMEPAGE="https://github.com/fcitx/fcitx5-kkc"
SRC_URI="https://github.com/fcitx/fcitx5-kkc/archive/refs/tags/5.0.6.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="5"
KEYWORDS="~amd64"
IUSE="+qt"

DEPEND="
	app-i18n/fcitx5
	qt? (
		app-i18n/fcitx5-qt
		kde-frameworks/extra-cmake-modules
		dev-qt/qtcore
		dev-qt/qtgui
		dev-qt/qtwidgets
	)
	app-i18n/libkkc
"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
	dev-libs/libgee:0.8
	dev-libs/json-glib[introspection]
"

src_configure() {
	local mycmakeargs=(
		-DENABLE_QT=$(usex qt)
	)

	cmake_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst
}
