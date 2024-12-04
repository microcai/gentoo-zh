# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} pypy)

inherit distutils-r1 pypi

DESCRIPTION="qq music support for feeluown"
HOMEPAGE="https://github.com/feeluown/feeluown-qqmusic"

LICENSE="GPL-3"
SLOT="1"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/marshmallow[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
"
PDEPEND="
	media-sound/feeluown
"

python_install_all() {
	distutils-r1_python_install_all
}
