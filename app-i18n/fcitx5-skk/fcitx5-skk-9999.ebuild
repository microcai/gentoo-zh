# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

if [[ "${PV}" =~ (^|\.)9999$ ]]; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/fcitx/fcitx5-skk"
fi

inherit xdg cmake

DESCRIPTION="Japanese SKK input engine for Fcitx5"
HOMEPAGE="https://fcitx-im.org/ https://github.com/fcitx/fcitx5-skk"
if [[ "$PV" =~ (^|\.)9999$ ]]; then
	SRC_URI=""
else
	SRC_URI="https://download.fcitx-im.org/fcitx5/${PN}/${P}.tar.xz"
fi

LICENSE="GPL-3+"
SLOT="5"
KEYWORDS="~amd64"

BDEPEND="kde-frameworks/extra-cmake-modules:5
		virtual/pkgconfig"

RDEPEND="app-i18n/fcitx5
		app-i18n/libskk
		dev-qt/qtcore:5
		app-i18n/fcitx5-qt[qt5,-only_plugin]
		app-i18n/skk-jisyo
		!app-i18n/fcitx-skk"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_LIBDIR="${EPREFIX}/usr/$(get_libdir)"
	)
	cmake_src_configure
}
