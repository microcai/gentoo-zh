# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Implementation of the asyncio (PEP 3156) event-loop with Qt"
HOMEPAGE="https://github.com/CabbageDevelopment/qasync"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	|| (
		dev-python/pyqt6[${PYTHON_USEDEP}]
		dev-python/pyside[${PYTHON_USEDEP}]
	)

"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
"
