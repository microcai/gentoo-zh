# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="Python tools for downloading YouTube Videos"
HOMEPAGE="https://github.com/pytube/pytube"
LICENSE="Unlicense"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
	)
"

python_test() {
	py.test -v || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
}
