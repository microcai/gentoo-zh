# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="fcitx5-unikey"
inherit cmake git-r3 xdg

DESCRIPTION="Unikey (Vietnamese Input Method) engine support for Fcitx"
HOMEPAGE="https://fcitx-im.org/ https://github.com/fcitx/fcitx5-unikey"
EGIT_REPO_URI="https://github.com/fcitx/fcitx5-unikey.git"

LICENSE="LGPL-2+ GPL-2+"
SLOT="5"
KEYWORDS=""
IUSE="+gui test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=app-i18n/fcitx-5.1.13:5
	>=app-i18n/fcitx-qt-5.1.4:5[qt6(+),-onlyplugin]
	gui? ( dev-qt/qtbase:6[dbus,gui,widgets] )
"
DEPEND="${RDEPEND}"
BDEPEND="
	kde-frameworks/extra-cmake-modules:0
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=(
		-DENABLE_QT=$(usex gui)
		-DENABLE_TEST=$(usex test)
	)
	cmake_src_configure
}
