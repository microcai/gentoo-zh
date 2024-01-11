# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..12} pypy3 )
inherit distutils-r1 pypi

DESCRIPTION="Structured Logging for Python"
HOMEPAGE="http://www.structlog.org/en/stable/"

LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	dev-python/hatch-fancy-pypi-readme[${PYTHON_USEDEP}]
	dev-python/hatch-vcs[${PYTHON_USEDEP}]
	test? (
		dev-python/pretend[$PYTHON_USEDEP]
		dev-python/freezegun[$PYTHON_USEDEP]
		dev-python/pytest-asyncio[$PYTHON_USEDEP]
	)
"

distutils_enable_tests pytest
