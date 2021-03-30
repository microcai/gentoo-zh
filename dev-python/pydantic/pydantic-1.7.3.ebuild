# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{7,8} pypy3 )

inherit distutils-r1

DESCRIPTION="Data validation and settings management using Python type hinting."
HOMEPAGE="https://pydantic-docs.helpmanual.io/"
MY_P="${P/_alpha/a}"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${MY_P}.tar.gz"
IUSE="+email +typing_extensions +dotenv test"


LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)
	email? (
		dev-python/python-email-validator[${PYTHON_USEDEP}]
	)
	typing_extensions? (
		dev-python/typing-extensions[${PYTHON_USEDEP}]
	)
	dotenv? (
		dev-python/python-dotenv[${PYTHON_USEDEP}]
	)
"

python_test() {
	py.test -v || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
}
