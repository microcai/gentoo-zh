# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit cmake-utils gnome2-utils xdg-utils git-r3
EGIT_REPO_URI="https://gitlab.com/fcitx/fcitx5-chinese-addons.git"

if [[ ! "${PV}" =~ (^|\.)9999$ ]]; then
	EGIT_COMMIT="cf54d3ab3d2369af7759b39baf202a7105fc67d5"
fi
SRC_URI="https://download.fcitx-im.org/data/py_stroke-20121124.tar.gz -> fcitx-data-py_stroke-20121124.tar.gz
https://download.fcitx-im.org/data/py_table-20121124.tar.gz -> fcitx-data-py_table-20121124.tar.gz
"

DESCRIPTION="Addons related to Chinese, including IME previous bundled inside fcitx4."
HOMEPAGE="https://gitlab.com/fcitx/fcitx5-chinese-addons"

LICENSE="BSD-1 GPL-2+ LGPL-2+ MIT"
SLOT="5"
KEYWORDS="~amd64"
IUSE="+opencc +gui test"
REQUIRED_USE=""

RDEPEND="app-i18n/fcitx5
	app-i18n/libime
	app-i18n/fcitx5-qt[qt5]
	dev-qt/qtwebengine[widgets]
	opencc? ( app-i18n/opencc:= )
	gui? ( dev-qt/qtwebengine:5 )"
DEPEND="${RDEPEND}
	kde-frameworks/extra-cmake-modules:5
	virtual/pkgconfig"

src_prepare() {
	ln -s "${DISTDIR}/fcitx-data-py_stroke-20121124.tar.gz" modules/pinyinhelper/py_stroke-20121124.tar.gz || die
	ln -s "${DISTDIR}/fcitx-data-py_table-20121124.tar.gz" modules/pinyinhelper/py_table-20121124.tar.gz || die
	cmake-utils_src_prepare
	xdg_environment_reset
}

src_configure() {
	local mycmakeargs=(
		-DLIB_INSTALL_DIR="${EPREFIX}/usr/$(get_libdir)"
		-DSYSCONFDIR="${EPREFIX}/etc"
		-DENABLE_GUI=$(usex gui)
		-DENABLE_OPENCC=$(usex opencc)
	)
	cmake-utils_src_configure
}

src_install(){
	cmake-utils_src_install
}
