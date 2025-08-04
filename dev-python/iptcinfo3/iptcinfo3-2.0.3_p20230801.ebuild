# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="To read/write image metadata"
HOMEPAGE="
	https://github.com/james-see/iptcinfo3
	https://pypi.org/project/IPTCInfo3/
"

hash=dfbfd902f64205ad42517dce288b46e06bc4b585
SRC_URI="https://github.com/james-see/${PN}/archive/${hash}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${hash}"

LICENSE="
	Artistic
	GPL-1
"

SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	test? (
		dev-python/pipenv[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
