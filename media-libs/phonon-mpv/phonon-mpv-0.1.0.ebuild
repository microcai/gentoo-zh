# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake multibuild

DESCRIPTION="Phonon Backend using MPV Player(libmpv)"
HOMEPAGE="https://github.com/OpenProgger/phonon-mpv"
SRC_URI="
	https://github.com/OpenProgger/phonon-mpv/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.tar.gz
"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+qt5 qt6"
REQUIRED_USE="|| ( qt5 qt6 )"

DEPEND="
	>=media-libs/phonon-4.12.0[qt5=,qt6=]
	>=media-video/mpv-0.29.0:=
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
		dev-qt/qtx11extras:5
	)
	qt6? (
		dev-qt/qtbase:6[gui,opengl,widgets,X]
	)
"
RDEPEND="${DEPEND}"
BDEPEND="
	kde-frameworks/extra-cmake-modules
	virtual/pkgconfig
"

pkg_setup() {
	MULTIBUILD_VARIANTS=( $(usev qt5) $(usev qt6) )
}

src_configure() {
	myconfigure() {
		local mycmakeargs=(
			-DQT_MAJOR_VERSION=${MULTIBUILD_VARIANT/qt/}
			-DPHONON_BUILD_${MULTIBUILD_VARIANT^^}=ON
		)
		if [[ ${MULTIBUILD_VARIANT} == qt6 ]]; then
			mycmakeargs+=( -DPHONON_BUILD_QT5=OFF )
		else
			mycmakeargs+=( -DPHONON_BUILD_QT6=OFF )
		fi
		cmake_src_configure
	}
	multibuild_foreach_variant myconfigure
}

src_compile() {
	multibuild_foreach_variant cmake_src_compile
}

src_install() {
	multibuild_foreach_variant cmake_src_install
}
