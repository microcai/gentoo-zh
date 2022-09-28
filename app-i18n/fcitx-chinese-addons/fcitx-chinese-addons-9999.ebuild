# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/fcitx/fcitx5-chinese-addons.git"
else
	MY_PN="fcitx5-chinese-addons"
	S="${WORKDIR}/${MY_PN}-${PV}"
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
IUSE="browser +cloudpinyin coverage +gui lua +opencc test"
REQUIRED_USE="
	coverage? ( test )
	browser? ( gui )
"
RESTRICT="!test? ( test )"

RDEPEND="
	>=app-i18n/fcitx-5.0.11:5
	>=app-i18n/libime-1.0.14:5

	>=dev-libs/boost-1.61:=
	dev-libs/libfmt

	cloudpinyin? ( net-misc/curl )
	opencc? ( app-i18n/opencc:= )
	gui? (
		dev-qt/qtgui:5
		dev-qt/qtcore:5
		dev-qt/qtwidgets:5
		dev-qt/qtdbus:5
		dev-qt/qtconcurrent:5
		app-i18n/fcitx-qt:5[qt5,-onlyplugin]
		browser? ( dev-qt/qtwebengine:5 )
	)
	lua? ( app-i18n/fcitx-lua:5 )
	test? ( dev-util/lcov )
"
DEPEND="${RDEPEND}
	kde-frameworks/extra-cmake-modules:5
	virtual/pkgconfig"

src_prepare() {
	ln -s "${DISTDIR}/fcitx-data-py_stroke-20121124.tar.gz" modules/pinyinhelper/py_stroke-20121124.tar.gz || die
	ln -s "${DISTDIR}/fcitx-data-py_table-20121124.tar.gz" modules/pinyinhelper/py_table-20121124.tar.gz || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_LIBDIR="${EPREFIX}/usr/$(get_libdir)"
		-DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}/etc"
		-DENABLE_GUI=$(usex gui)
		-DENABLE_OPENCC=$(usex opencc)
		-DENABLE_BROWSER=$(usex browser)
		-DENABLE_CLOUDPINYIN=$(usex cloudpinyin)
		-DENABLE_TEST=$(usex test)
		-DENABLE_COVERAGE=$(usex coverage)
		-DUSE_WEBKIT=no
	)
	cmake_src_configure
}
