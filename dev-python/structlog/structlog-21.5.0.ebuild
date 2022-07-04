# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{9..11} pypy3 )
inherit distutils-r1

DESCRIPTION="Structured Logging for Python"
HOMEPAGE="http://www.structlog.org/en/stable/"
SRC_URI="https://github.com/hynek/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=""
BDEPEND="
	test? (
		dev-python/pretend[$PYTHON_USEDEP]
		dev-python/freezegun[$PYTHON_USEDEP]
	)
"

distutils_enable_tests pytest
