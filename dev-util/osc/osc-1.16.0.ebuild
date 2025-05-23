# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} python3_13t )
inherit distutils-r1

DESCRIPTION="The Command Line Interface to work with an Open Build Service"
HOMEPAGE="https://github.com/openSUSE/osc"
SRC_URI="https://github.com/openSUSE/osc/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64"

DEPEND="
	dev-python/cryptography
	dev-python/ruamel-yaml
	dev-python/urllib3
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-python/argparse-manpage
	dev-python/cryptography
	dev-python/urllib3
"
