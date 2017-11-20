# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_6,2_7,3_3,3_4} )
inherit distutils-r1

DESCRIPTION="Meta-commands handler for Postgres Database."
HOMEPAGE="https://github.com/dbcli/pgspecial"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="
	>=dev-python/click-4.1[${PYTHON_USEDEP}]
	>=dev-python/python-sqlparse-0.1.19[${PYTHON_USEDEP}]
"
