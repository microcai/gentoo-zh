# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} pypy3 )
inherit distutils-r1

DESCRIPTION="Create and extract conda packages of various formats"
HOMEPAGE="https://github.com/conda/conda-package-handling"
SRC_URI="https://github.com/conda/conda-package-handling/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~x86"

DEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"

RDEPEND="${DEPEND}"
BDEPEND=""

distutils_enable_tests pytest

python_prepare_all() {
	sed -i 's/archive_and_deps/archive/' setup.py || die
	distutils-r1_python_prepare_all
}
