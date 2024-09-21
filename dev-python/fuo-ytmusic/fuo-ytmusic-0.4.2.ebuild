# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..12})
DISTUTILS_USE_PEP517=poetry

inherit distutils-r1

DESCRIPTION="youtube music support for feeluown"
HOMEPAGE="https://github.com/feeluown/feeluown-ytmusic"

SRC_URI="https://github.com/feeluown/feeluown-ytmusic/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/feeluown-ytmusic-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	dev-python/cachetools[${PYTHON_USEDEP}]
	dev-python/ytmusicapi[${PYTHON_USEDEP}]
"

PDEPEND="
	media-sound/feeluown
"

python_install_all() {
	distutils-r1_python_install_all
}
