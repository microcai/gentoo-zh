# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/fcitx/fcitx5-qt.git"
else
	MY_PN="fcitx5-qt"
	S="${WORKDIR}/${MY_PN}-${PV}"
	SRC_URI="https://github.com/fcitx/fcitx5-qt/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Qt library and IM module for fcitx5"
HOMEPAGE="https://github.com/fcitx/fcitx5-qt"

LICENSE="BSD-1 GPL-2+ LGPL-2+ MIT"
SLOT="5"
IUSE="+qt5 onlyplugin qt6"
REQUIRED_USE="|| ( qt5 qt6 )"

RDEPEND="
	!onlyplugin? (
		>=app-i18n/fcitx-5.0.16:5
	)
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtdbus:5
		dev-qt/qtgui:5=
		dev-qt/qtwidgets:5
		dev-qt/qtconcurrent:5
	)
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libxkbcommon

	qt6? (
		dev-qt/qtbase:6[dbus,gui]
	)
	kde-frameworks/extra-cmake-modules:5
"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}/etc"
		-DCMAKE_INSTALL_LIBDIR="${EPREFIX}/usr/$(get_libdir)"
		-DCMAKE_BUILD_TYPE=Release
		-DENABLE_QT4=no
		-DENABLE_QT5=$(usex qt5)
		-DENABLE_QT6=$(usex qt6)
		-DBUILD_ONLY_PLUGIN=$(usex onlyplugin)
	)
	cmake_src_configure
}
