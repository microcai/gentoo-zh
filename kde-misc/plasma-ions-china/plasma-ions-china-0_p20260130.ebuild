# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

SRC_HASH="84eedb4bb3a9addc21b7288aa22b84ef211e3603"
KDEPLASMAADDONS_VERSION="6.5.5"

DESCRIPTION="A collection of plasma weather ions for Chinese users"
HOMEPAGE="https://github.com/arenekosreal/plasma-ions-china"
SRC_URI="
	https://github.com/arenekosreal/plasma-ions-china/archive/${SRC_HASH}.tar.gz -> ${P}.tar.gz
	mirror://kde/stable/plasma/${KDEPLASMAADDONS_VERSION}/kdeplasma-addons-${KDEPLASMAADDONS_VERSION}.tar.xz
"

S="${WORKDIR}/${PN}-${SRC_HASH}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-qt/qtbase:6
	>=kde-plasma/kdeplasma-addons-6.5:=
"
DEPEND="${RDEPEND}"
BDEPEND="kde-frameworks/extra-cmake-modules"

src_unpack() {
	unpack "${P}.tar.gz"
}

src_configure() {
	local mycmakeargs=(
		-DEXTERNAL_PROJECT_URL_KDEPLASMA_ADDONS="file://${DISTDIR}/kdeplasma-addons-${KDEPLASMAADDONS_VERSION}.tar.xz"
	)
	cmake_src_configure
}
