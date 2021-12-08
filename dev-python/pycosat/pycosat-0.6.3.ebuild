# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_9 )
inherit distutils-r1

DESCRIPTION="Python bindings to picosat (a SAT solver)"
HOMEPAGE="https://github.com/ContinuumIO/pycosat"
SRC_URI="https://github.com/ContinuumIO/pycosat/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~x86"

DISTUTILS_USE_SETUPTOOLS=no

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

distutils_enable_tests pytest
