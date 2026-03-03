# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=scikit-build-core
DISTUTILS_EXT=1
inherit distutils-r1 pypi

DESCRIPTION="High quality, one-dimensional sample-rate conversion library for Python"
HOMEPAGE="
	https://github.com/dofuuz/python-soxr
	https://pypi.org/project/soxr/
"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	media-libs/soxr
"
BDEPEND="
	dev-python/nanobind[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=( )

distutils_enable_tests pytest
