# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=(python3_{11..13})
inherit distutils-r1

DESCRIPTION="Python bindings to picosat (a SAT solver)"
HOMEPAGE="https://github.com/conda/pycosat"
SRC_URI="https://github.com/conda/pycosat/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~riscv ~x86"

distutils_enable_tests pytest
