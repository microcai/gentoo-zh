# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3
EGIT_REPO_URI="https://github.com/fcitx/fcitx5-configtool.git"
DESCRIPTION="Configuration module for Fcitx"
HOMEPAGE="https://fcitx-im.org/ https://github.com/fcitx/fcitx5-configtool"

LICENSE="GPL-2+"
SLOT="5"
IUSE="kcm +config-qt test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=app-i18n/fcitx-5.0.4:5
	>=app-i18n/fcitx-qt-5.0.2:5[qt5,-onlyplugin]
	dev-qt/qtcore:5
	dev-qt/qtconcurrent:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	kde-frameworks/kwidgetsaddons:5
	virtual/libintl
	x11-libs/libX11
	x11-libs/libxkbcommon
	x11-libs/libxkbfile
	kcm? (
		dev-qt/qtquickcontrols2:5
		kde-frameworks/kconfigwidgets:5
		kde-frameworks/kcoreaddons:5
		kde-frameworks/kdeclarative:5
		kde-frameworks/ki18n:5
		kde-frameworks/kiconthemes:5
		kde-frameworks/kirigami:5
		kde-frameworks/kpackage:5
		kde-plasma/libplasma:5
	)
	config-qt? (
		kde-frameworks/kitemviews:5
	)
"

DEPEND="${RDEPEND}
	kde-frameworks/extra-cmake-modules:0
	sys-devel/gettext
	virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DKDE_INSTALL_USE_QT_SYS_PATHS=yes
		-DENABLE_KCM=$(usex kcm)
		-DENABLE_CONFIG_QT=$(usex config-qt)
		-DENABLE_TEST=$(usex test)
		-DUSE_QT6=Off
	)

	cmake_src_configure
}
