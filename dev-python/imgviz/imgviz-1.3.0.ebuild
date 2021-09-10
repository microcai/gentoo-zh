# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_9 )
inherit distutils-r1

DESCRIPTION="mage Visualization Tools"
HOMEPAGE="https://github.com/wkentaro/imgviz"
SRC_URI="https://github.com/wkentaro/imgviz/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~x86"

DEPEND="dev-python/matplotlib
		dev-python/numpy
		dev-python/pillow
		dev-python/QtPy
		dev-python/termcolor
		dev-python/pyyaml
		dev-python/setuptools"
RDEPEND="${DEPEND}"
BDEPEND=""
