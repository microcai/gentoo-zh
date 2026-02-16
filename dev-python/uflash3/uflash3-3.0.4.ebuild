# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="A module and utility to flash Python onto the BBC micro:bit"
HOMEPAGE="
	https://github.com/blackteahamburger/uflash
	https://pypi.org/project/uflash3
"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/microfs2-2.0.6[${PYTHON_USEDEP}]
	>=dev-python/nudatus-0.0.2[${PYTHON_USEDEP}]
	dev-python/semver[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
