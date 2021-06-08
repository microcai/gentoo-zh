# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_9 )
inherit distutils-r1

DESCRIPTION="Create and extract conda packages of various formats"
HOMEPAGE="https://github.com/conda/conda-package-handling"
SRC_URI="https://github.com/conda/conda-package-handling/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~x86"

DEPEND="dev-python/tqdm
		dev-python/six"

RDEPEND="${DEPEND}"
BDEPEND=""

distutils_enable_tests pytest

src_prepare() {
	sed -i 's/archive_and_deps/archive/' setup.py
	default
}
