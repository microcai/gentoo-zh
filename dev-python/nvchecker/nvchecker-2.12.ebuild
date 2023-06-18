# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )
inherit distutils-r1

DESCRIPTION="nvchecker is for checking if a new version of some software has been released"
HOMEPAGE="https://pypi.org/project/nvchecker/"
SRC_URI="https://github.com/lilydjwg/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="ini notify"
PROPERTIES="test_network"
RESTRICT="test"

BDEPEND="
	test? (
		dev-python/flaky[$PYTHON_USEDEP]
		dev-python/pytest-asyncio[$PYTHON_USEDEP]
		dev-python/pytest-httpbin[$PYTHON_USEDEP]
	)
"
RDEPEND="
	dev-python/appdirs[$PYTHON_USEDEP]
	dev-python/structlog[$PYTHON_USEDEP]
	dev-python/tomli[$PYTHON_USEDEP]
	>=dev-python/tornado-6[${PYTHON_USEDEP}]
	ini? (
		dev-python/iniconfig[$PYTHON_USEDEP]
	)
	notify? (
		dev-python/pygobject[$PYTHON_USEDEP]
		virtual/notification-daemon
	)
"

distutils_enable_tests pytest

python_install_all() {
	distutils-r1_python_install_all

	if ! use ini; then
		rm "${ED}"/usr/bin/nvchecker-ini2toml || die
	fi

	if ! use notify; then
		rm "${ED}"/usr/bin/nvchecker-notify || die
	fi
}
