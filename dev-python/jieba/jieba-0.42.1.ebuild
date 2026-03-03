# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Chinese text segmentation library"
HOMEPAGE="
	https://github.com/fxsjy/jieba
	https://pypi.org/project/jieba/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

# Tests are standalone scripts incompatible with pytest, and require
# missing data files (userdict.txt, extra_dict/) not included in sdist
RESTRICT="test"

src_prepare() {
	default

	# Remove deprecated license classifier
	sed -i "/License ::/d" setup.py || die
}
