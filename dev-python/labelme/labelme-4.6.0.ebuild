# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=(python3_9)
inherit desktop distutils-r1

DESCRIPTION="Image Polygonal Annotation with Python"
HOMEPAGE="https://github.com/wkentaro/labelme"
SRC_URI="https://github.com/wkentaro/labelme/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"

DEPEND="dev-python/imgviz[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/QtPy[${PYTHON_USEDEP}]
		dev-python/termcolor[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=(
	"${FILESDIR}/subElementRect.patch"
)

python_install_all() {
	distutils-r1_python_install_all
	newicon ${PN}{/icons/icon,}.png
	domenu ${PN}.desktop
}
