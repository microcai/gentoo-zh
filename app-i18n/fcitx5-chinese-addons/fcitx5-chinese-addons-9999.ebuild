# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake xdg

if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/fcitx/fcitx5-chinese-addons.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/fcitx/fcitx5-chinese-addons/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

SRC_URI+="
https://download.fcitx-im.org/data/py_stroke-20121124.tar.gz -> fcitx-data-py_stroke-20121124.tar.gz
https://download.fcitx-im.org/data/py_table-20121124.tar.gz -> fcitx-data-py_table-20121124.tar.gz
"

DESCRIPTION="Addons related to Chinese, including IME previous bundled inside fcitx4."
HOMEPAGE="https://github.com/fcitx/fcitx5-chinese-addons"

LICENSE="BSD-1 GPL-2+ LGPL-2+ MIT"
SLOT="5"
IUSE="+opencc +gui browser test"
REQUIRED_USE=""

RDEPEND="app-i18n/fcitx5
	app-i18n/libime
	opencc? ( app-i18n/opencc:= )
	gui? (
		dev-qt/qtcore:5
		dev-qt/qtdbus:5
		dev-qt/qtconcurrent:5
		app-i18n/fcitx5-qt[qt5,-only_plugin]
		browser? (
			dev-qt/qtwebengine:5
		)
	)"
DEPEND="${RDEPEND}
	kde-frameworks/extra-cmake-modules:5
	virtual/pkgconfig"

src_prepare() {
	ln -s "${DISTDIR}/fcitx-data-py_stroke-20121124.tar.gz" modules/pinyinhelper/py_stroke-20121124.tar.gz || die
	ln -s "${DISTDIR}/fcitx-data-py_table-20121124.tar.gz" modules/pinyinhelper/py_table-20121124.tar.gz || die
	cmake_src_prepare
	xdg_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_LIBDIR="${EPREFIX}/usr/$(get_libdir)"
		-DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}/etc"
		-DENABLE_GUI=$(usex gui)
		-DENABLE_OPENCC=$(usex opencc)
		-DENABLE_BROWSER=$(usex browser)
		-DUSE_WEBKIT=no
	)
	cmake_src_configure
}

src_install(){
	cmake_src_install
}
