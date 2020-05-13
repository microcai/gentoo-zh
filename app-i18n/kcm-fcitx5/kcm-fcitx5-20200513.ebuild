# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit cmake-utils git-r3
EGIT_REPO_URI="https://github.com/fcitx/kcm-fcitx5.git"
EGIT_COMMIT="3a1192df4a6cba04cd935539000e51cc73e72052"

DESCRIPTION="KDE configuration module for Fcitx"
HOMEPAGE="https://fcitx-im.org/ https://gitlab.com/fcitx/kcm-fcitx5"

LICENSE="GPL-2+"
SLOT="5-plasma5"
KEYWORDS="~amd64 ~x86"
IUSE="kde"

RDEPEND="app-i18n/fcitx5
	app-i18n/fcitx5-qt[qt5]
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	kde-frameworks/kitemviews:5
	kde-frameworks/kwidgetsaddons:5
	virtual/libintl
	x11-libs/libX11
	x11-libs/libxkbfile
	kde? (
		kde-frameworks/kconfigwidgets:5
		kde-frameworks/kcoreaddons:5
		kde-frameworks/ki18n:5
		kde-frameworks/knewstuff:5
		kde-frameworks/kio:5
	)
	!${CATEGORY}/${PN}:4[-minimal(-)]"
DEPEND="${RDEPEND}
	kde-frameworks/extra-cmake-modules:5
	sys-devel/gettext
	virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DKDE_INSTALL_USE_QT_SYS_PATHS=yes
		-DENABLE_KCM=$(usex kde)
	)

	cmake-utils_src_configure
}
