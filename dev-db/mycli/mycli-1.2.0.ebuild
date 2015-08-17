# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils

DESCRIPTION="A Terminal Client for MySQL with AutoCompletion and Syntax Highlighting."
HOMEPAGE="https://github.com/dbcli/mycli"
SRC_URI="https://github.com/dbcli/mycli/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64  ~x86"

IUSE=""

RDEPEND=""

src_compile() {
	distutils_src_compile
}

src_install () {
	distutils_src_install
}