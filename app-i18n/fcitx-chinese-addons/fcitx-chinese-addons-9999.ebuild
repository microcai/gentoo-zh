# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3 xdg

EGIT_REPO_URI="https://github.com/fcitx/fcitx5-chinese-addons.git"
DESCRIPTION="Addons related to Chinese, including IME previous bundled inside fcitx4."
HOMEPAGE="https://github.com/fcitx/fcitx5-chinese-addons"
LICENSE="GPL-2+ LGPL-2+"
SLOT="5"
IUSE="webengine +cloudpinyin coverage +qt5 lua +opencc test"
REQUIRED_USE="
	webengine? ( qt5 )
"
RESTRICT="!test? ( test )"

RDEPEND="
	>=app-i18n/fcitx-5.1.5:5
	>=app-i18n/libime-1.1.3:5
	>=dev-libs/boost-1.61:=
	cloudpinyin? ( net-misc/curl )
	opencc? ( app-i18n/opencc:= )
	qt5? (
		dev-qt/qtconcurrent:5
		app-i18n/fcitx-qt:5[qt5,-onlyplugin]
		webengine? ( dev-qt/qtwebengine:5 )
	)
	lua? ( app-i18n/fcitx-lua:5 )
"
DEPEND="
	${RDEPEND}
	test? ( dev-util/lcov )
"
BDEPEND="
	kde-frameworks/extra-cmake-modules:0
	virtual/pkgconfig
"

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_LIBDIR="${EPREFIX}/usr/$(get_libdir)"
		-DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}/etc"
		-DENABLE_GUI=$(usex qt5)
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
			-DENABLE_BROWSER=$(usex webengine)
		)
	fi
	cmake_src_configure
}
