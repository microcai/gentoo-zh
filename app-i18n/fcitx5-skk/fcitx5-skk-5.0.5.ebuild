# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake gnome2-utils

DESCRIPTION="libskk wrapper for Fcitx5"
HOMEPAGE="https://github.com/fcitx/fcitx5-skk"
SRC_URI="https://download.fcitx-im.org/fcitx5/${PN}/${P}.tar.xz -> ${P}.tar.xz"

LICENSE="GPL-3+"
SLOT="5"
KEYWORDS="~amd64"

RDEPEND="app-i18n/fcitx5
		app-i18n/libskk
		dev-qt/qtcore:5
		app-i18n/fcitx5-qt[qt5,-only_plugin]
		!app-i18n/fcitx-skk"

DEPEND="${RDEPEND}
		kde-frameworks/extra-cmake-modules:5
		virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_LIBDIR="${EPREFIX}/usr/$(get_libdir)"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
