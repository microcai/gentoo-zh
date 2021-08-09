# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=(python3_9)
inherit distutils-r1

DESCRIPTION="Image Polygonal Annotation with Python"
HOMEPAGE="https://github.com/wkentaro/labelme"
SRC_URI="https://github.com/wkentaro/labelme/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"

DEPEND="dev-python/imgviz
		dev-python/matplotlib
		dev-python/numpy
		dev-python/QtPy
		dev-python/termcolor
		dev-python/pyyaml
		dev-python/setuptools"
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=(
	"${FILESDIR}/subElementRect.patch"
)

src_install() {
	distutils-r1_src_install "$@"
	install -Dm644 "labelme/icons/icon.png" "${D}/usr/share/pixmaps/labelme.png"
	install -Dm644 "labelme.desktop" -t "${D}/usr/share/applications"
}
