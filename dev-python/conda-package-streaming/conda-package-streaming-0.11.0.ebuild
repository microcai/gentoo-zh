# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{9..13} pypy3 )
inherit distutils-r1

DESCRIPTION="An efficient library to read from new and old conda packages"
HOMEPAGE="https://github.com/conda/conda-package-streaming"
SRC_URI="https://github.com/conda/conda-package-streaming/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~x86"

DEPEND="
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/zstandard[${PYTHON_USEDEP}]"

RDEPEND="${DEPEND}"

distutils_enable_tests pytest
