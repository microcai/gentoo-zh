# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg cmake

DESCRIPTION="Japanese SKK input engine for Fcitx5"
HOMEPAGE="https://fcitx-im.org/ https://github.com/fcitx/fcitx5-skk"
if [[ "${PV}" =~ (^|\.)9999$ ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/fcitx/fcitx5-skk"
	SRC_URI=""
else
	KEYWORDS="~amd64 ~x86"
	MY_PN="fcitx5-skk"
	MY_P="${MY_PN}-${PV}"
	S="${WORKDIR}/${MY_PN}-${PV}"
	SRC_URI="https://download.fcitx-im.org/fcitx5/${MY_PN}/${MY_P}.tar.xz"
fi

LICENSE="GPL-3+"
SLOT="5"

BDEPEND="kde-frameworks/extra-cmake-modules:5
		virtual/pkgconfig"

RDEPEND="app-i18n/fcitx:5
		app-i18n/libskk
		dev-qt/qtcore:5
		app-i18n/fcitx-qt[qt5,-onlyplugin]
		app-i18n/skk-jisyo"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_LIBDIR="${EPREFIX}/usr/$(get_libdir)"
	)
	cmake_src_configure
}
