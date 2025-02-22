# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="fcitx5-cskk"

inherit cmake

DESCRIPTION="SKK input method plugin for fcitx5 that uses LibCSKK"
HOMEPAGE="https://github.com/fcitx/fcitx5-cskk"
SRC_URI="https://github.com/fcitx/fcitx5-cskk/archive/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${MY_PN}-${PV}"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+qt5"

DEPEND="
	app-i18n/cskk
	>=app-i18n/fcitx-5.0.6:5
	app-i18n/fcitx-qt[qt5?,-onlyplugin]
	app-i18n/libskk
	app-i18n/skk-jisyo
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
	)
"
RDEPEND="${DEPEND}"
BDEPEND="
	kde-frameworks/extra-cmake-modules
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=(
		-DENABLE_QT=$(usex qt5)
	)
	cmake_src_configure
}
