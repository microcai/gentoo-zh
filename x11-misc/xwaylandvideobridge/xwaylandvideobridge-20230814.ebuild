#Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit vcs-snapshot cmake

DESCRIPTION="Utility to allow streaming Wayland windows to X applications"
HOMEPAGE="https://invent.kde.org/system/xwaylandvideobridge"

EGIT_COMMIT="16091a997d40eb9e5a46f3f0eecceff8fe348c87"
SRC_URI="https://invent.kde.org/system/${PN}/-/archive/${EGIT_COMMIT}/${PN}-${EGIT_COMMIT}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
RESTRICT="mirror"

KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdeclarative:5
	dev-qt/qtx11extras:5
	kde-frameworks/extra-cmake-modules:0
	kde-frameworks/kcoreaddons:5
	kde-frameworks/kwidgetsaddons:5
	kde-frameworks/kwindowsystem:5
	kde-frameworks/knotifications:5
	kde-frameworks/ki18n:5
	kde-plasma/kpipewire:5
	x11-libs/libxcb
"
BDEPEND="
	${DEPEND}
	dev-util/ninja
"
RDEPEND="
	${DEPEND}
	x11-themes/hicolor-icon-theme
"

PATCHES=(
	"${FILESDIR}/cursor-mode.patch"
)
