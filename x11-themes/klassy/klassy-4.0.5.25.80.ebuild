# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

MY_PV=$(ver_rs 2 '.breeze')
DESCRIPTION="Highly customizable theme plugin for KDE Plasma desktop"
HOMEPAGE="https://github.com/paulmcauley/klassy"
SRC_URI="https://github.com/paulmcauley/klassy/archive/refs/tags/${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

DEPEND="
	kde-plasma/breeze:5
	kde-frameworks/frameworkintegration:5
	x11-themes/hicolor-icon-theme
	kde-plasma/kdecoration:5
	kde-frameworks/kirigami:5
	kde-frameworks/kwayland:5
	kde-frameworks/extra-cmake-modules:0
"
RDEPEND="${DEPEND}"
BDEPEND="kde-frameworks/kcmutils:5"

S="${WORKDIR}/${PN}-${MY_PV}"
