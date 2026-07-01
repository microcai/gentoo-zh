# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..13} )
inherit distutils-r1

DESCRIPTION="Cross platform menu item installation"
HOMEPAGE="https://github.com/conda/menuinst"
SRC_URI="https://github.com/conda/menuinst/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	$(python_gen_cond_dep 'dev-python/setuptools-scm[${PYTHON_USEDEP}]')
"

export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}

distutils_enable_tests pytest
