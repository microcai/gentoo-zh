# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

MY_PN="fcitx5-qt"
S="${WORKDIR}/${MY_PN}-${PV}"
SRC_URI="https://download.fcitx-im.org/fcitx5/${MY_PN}/${MY_PN}-${PV}.tar.xz -> ${P}.tar.xz"
KEYWORDS="~amd64 ~arm64 ~loong ~riscv ~x86"
PATCHES="${FILESDIR}/${P}-backport-conditional-wayland.patch"

DESCRIPTION="Qt library and IM module for fcitx5"
HOMEPAGE="https://github.com/fcitx/fcitx5-qt"

LICENSE="BSD LGPL-2.1+"
SLOT="5"
IUSE="+qt5 onlyplugin staticplugin qt6 wayland"
REQUIRED_USE="
	|| ( qt5 qt6 )
	staticplugin? ( onlyplugin )
"

RDEPEND="
	!onlyplugin? (
		>=app-i18n/fcitx-5.1.5:5
	)
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtdbus:5
		dev-qt/qtgui:5=
		dev-qt/qtwidgets:5
		dev-qt/qtconcurrent:5
	)
	qt6? (
		dev-qt/qtbase:6[dbus,gui,wayland?,widgets]
	)
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libxkbcommon
"
DEPEND="${RDEPEND}"
BDEPEND="
	kde-frameworks/extra-cmake-modules:0
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}/etc"
		-DCMAKE_INSTALL_LIBDIR="${EPREFIX}/usr/$(get_libdir)"
		-DCMAKE_BUILD_TYPE=Release
		-DENABLE_QT4=no
		-DENABLE_QT5=$(usex qt5)
		-DENABLE_QT6=$(usex qt6)
		-DENABLE_QT6_WAYLAND_WORKAROUND=$(usex wayland)
		-DBUILD_ONLY_PLUGIN=$(usex onlyplugin)
		-DBUILD_STATIC_PLUGIN=$(usex staticplugin)
	)
	cmake_src_configure
}
