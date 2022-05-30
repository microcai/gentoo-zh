# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg cmake

MY_PN="fcitx5-kkc"
S="${WORKDIR}/${MY_PN}-${PV}"
DESCRIPTION="Japanese Kana Kanji conversion engine for Fcitx5"
HOMEPAGE="https://github.com/fcitx/fcitx5-kkc"
SRC_URI="https://github.com/fcitx/fcitx5-kkc/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="5"
KEYWORDS="~amd64"
IUSE="+qt"

DEPEND="
	app-i18n/fcitx:5
	app-i18n/libkkc
	kde-frameworks/extra-cmake-modules
	qt? (
		app-i18n/fcitx-qt
	)
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-libs/json-glib[introspection]
	dev-libs/libgee:0.8
	virtual/pkgconfig
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
