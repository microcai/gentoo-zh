# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3
EGIT_REPO_URI="https://github.com/fcitx/fcitx5-configtool.git"
DESCRIPTION="Configuration module for Fcitx"
HOMEPAGE="https://fcitx-im.org/ https://github.com/fcitx/fcitx5-configtool"

LICENSE="GPL-2+"
SLOT="5"
IUSE="kcm +config-qt test qt6 qt5"
RESTRICT="!test? ( test )"

REQUIRED_USE="^^ ( qt5 qt6 )"

RDEPEND="
	>=app-i18n/fcitx-5.1.6:5
	>=app-i18n/fcitx-qt-5.1.5:5[qt5?,qt6?,-onlyplugin]
	app-text/iso-codes
	qt5? (
		dev-qt/qtconcurrent:5
		dev-qt/qtcore:5
		dev-qt/qtdbus:5
		dev-qt/qtgui:5
		dev-qt/qtsvg:5
		dev-qt/qtwidgets:5
		dev-qt/qtx11extras:5
		kde-frameworks/kwidgetsaddons:5
	)

	qt6? (
		kde-frameworks/kwidgetsaddons:6
		kde-frameworks/kdbusaddons:6
		kde-frameworks/kitemviews:6
		>=dev-qt/qtbase-6.7[dbus]
	)

	sys-devel/gettext
	virtual/libintl
	x11-libs/libX11
	x11-libs/libxkbfile
	x11-misc/xkeyboard-config
	config-qt? (
		qt5? ( kde-frameworks/kitemviews:5 )
		qt6? ( kde-frameworks/kitemviews:6 )
	)
	kcm? (
		x11-libs/libxkbcommon
		qt5? (
			dev-qt/qtquickcontrols2:5
			kde-frameworks/kcoreaddons:5
			kde-frameworks/kdeclarative:5
			kde-frameworks/ki18n:5
			kde-frameworks/kiconthemes:5
			kde-frameworks/kirigami:5
			kde-frameworks/kpackage:5
			kde-plasma/libplasma:5
		)
		qt6? (
			kde-frameworks/kcoreaddons:6
			kde-frameworks/kdeclarative:6
			kde-frameworks/ki18n:6
			kde-frameworks/kiconthemes:6
			kde-frameworks/kirigami:6
			kde-frameworks/kpackage:6
			kde-plasma/libplasma:6
		)
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
