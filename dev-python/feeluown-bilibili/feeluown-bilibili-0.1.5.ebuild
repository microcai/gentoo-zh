# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 pypi

DESCRIPTION="bilibili support for feeluown"
HOMEPAGE="https://github.com/feeluown/feeluown-bilibili"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	dev-python/cachetools[${PYTHON_USEDEP}]
"

PDEPEND="
	media-sound/feeluown
"

PATCHES=(
	"${FILESDIR}/${PN}-0.1.5-replace-pycryptodomex.patch"
)

python_install_all() {
	distutils-r1_python_install_all
}
