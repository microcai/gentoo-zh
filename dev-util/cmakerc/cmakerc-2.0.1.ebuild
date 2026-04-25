# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A Resource Compiler in a Single CMake Script"
HOMEPAGE="https://github.com/vector-of-bool/cmrc"
SRC_URI="https://github.com/vector-of-bool/cmrc/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/cmrc-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

PATCHES=(
	"${FILESDIR}/${P}-CMakeLists-minimum-version.patch"
	"${FILESDIR}/${P}-CMakeRC.cmake-minimum-version.patch"
	"${FILESDIR}/${P}-installation.patch"
)
