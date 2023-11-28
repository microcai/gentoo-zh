# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3 xdg

EGIT_REPO_URI="https://github.com/fcitx/fcitx5-chinese-addons.git"
DESCRIPTION="Addons related to Chinese, including IME previous bundled inside fcitx4."
HOMEPAGE="https://github.com/fcitx/fcitx5-chinese-addons"
LICENSE="GPL-2+ LGPL-2+"
SLOT="5"
IUSE="browser +cloudpinyin coverage +gui lua +opencc test"
REQUIRED_USE="
	coverage? ( test )
	browser? ( gui )
"
RESTRICT="!test? ( test )"

RDEPEND="
	>=app-i18n/fcitx-5.1.2:5
	>=app-i18n/libime-1.1.3:5

	>=dev-libs/boost-1.61:=
	dev-libs/libfmt

	cloudpinyin? ( net-misc/curl )
	opencc? ( app-i18n/opencc:= )
	gui? (
		dev-qt/qtgui:5
		dev-qt/qtcore:5
		dev-qt/qtwidgets:5
		dev-qt/qtconcurrent:5
		app-i18n/fcitx-qt:5[qt5,-onlyplugin]
		browser? ( !loong? ( !x86? ( dev-qt/qtwebengine:5 ) ) )
	)
	!arm64? ( !loong? ( lua? ( app-i18n/fcitx-lua:5 ) ) )
	test? ( dev-util/lcov )
"
DEPEND="${RDEPEND}
	kde-frameworks/extra-cmake-modules:0
	virtual/pkgconfig"

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_LIBDIR="${EPREFIX}/usr/$(get_libdir)"
		-DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}/etc"
		-DENABLE_GUI=$(usex gui)
		-DENABLE_OPENCC=$(usex opencc)
		-DENABLE_CLOUDPINYIN=$(usex cloudpinyin)
		-DENABLE_TEST=$(usex test)
		-DENABLE_COVERAGE=$(usex coverage)
		-DENABLE_QT6=Off
		-DUSE_WEBKIT=no
	)
	if use loong || use x86; then
		mycmakeargs+=(
			-DENABLE_BROWSER=no
		)
	else
		mycmakeargs+=(
			-DENABLE_BROWSER=$(usex browser)
		)
	fi
	cmake_src_configure
}
