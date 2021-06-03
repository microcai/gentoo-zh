# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DISTUTILS_USE_SETUPTOOLS=pyproject.toml
PYTHON_COMPAT=( python3_{8,9} pypy3 )
inherit distutils-r1

DESCRIPTION="Style-preserving TOML library for Python"
HOMEPAGE="https://github.com/sdispater/tomlkit"
MY_P="${P/_alpha/a}"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${MY_P}.tar.gz"
IUSE="test"


LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)
"

src_prepare() {
	sed -i -e '/{include = "tests", format = "sdist"}/d' pyproject.toml || die
	sed -i -e 's/{include = "tomlkit"},/{include = "tomlkit"}/' pyproject.toml || die
	rm setup.py
	distutils-r1_src_prepare
}

python_test() {
	py.test -v || die "Tests fail with ${EPYTHON}"
}

