# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 cmake

DESCRIPTION="A collection of plasma weather ions for Chinese users"
HOMEPAGE="https://github.com/arenekosreal/plasma-ions-china"

LICENSE="GPL-3+"
SLOT="0"

RDEPEND="
	dev-qt/qtbase:6
	>=kde-plasma/kdeplasma-addons-6.5:=
"
DEPEND="${RDEPEND}"
BDEPEND="kde-frameworks/extra-cmake-modules"

EGIT_REPO_URI="https://github.com/arenekosreal/plasma-ions-china.git"

src_configure() {
	local mycmakeargs=( -DPlasmaWeather_ROOT="${S}" )
	cmake_src_configure
}
