# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{8,9} )

inherit distutils-r1

DESCRIPTION="Implementation of the asyncio (PEP 3156) event-loop with Qt"
HOMEPAGE="https://github.com/CabbageDevelopment/qasync"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/PyQt5[${PYTHON_USEDEP}]
"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
"
