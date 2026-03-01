# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 cmake

KDEPLASMAADDONS_VERSION="6.5.5"

DESCRIPTION="A collection of plasma weather ions for Chinese users"
HOMEPAGE="https://github.com/arenekosreal/plasma-ions-china"

EGIT_REPO_URI="https://github.com/arenekosreal/plasma-ions-china.git"
SRC_URI="mirror://kde/stable/plasma/${KDEPLASMAADDONS_VERSION}/kdeplasma-addons-${KDEPLASMAADDONS_VERSION}.tar.xz"

LICENSE="GPL-3+"
SLOT="0"

RDEPEND="
	dev-qt/qtbase:6
	>=kde-plasma/kdeplasma-addons-6.5:=
"
DEPEND="${RDEPEND}"
BDEPEND="kde-frameworks/extra-cmake-modules"

src_unpack() {
	git-r3_src_unpack
}

src_configure() {
	local mycmakeargs=(
		-DEXTERNAL_PROJECT_URL_KDEPLASMA_ADDONS="file://${DISTDIR}/kdeplasma-addons-${KDEPLASMAADDONS_VERSION}.tar.xz"
	)
	cmake_src_configure
}
