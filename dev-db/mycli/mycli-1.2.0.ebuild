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

RDEPEND="
	>=dev-python/click-4.1
	>=dev-python/pygments-2.0
	=dev-python/prompt_toolkit-0.46
	>=dev-python/pymysql-0.6.6
	=dev-python/python-sqlparse-0.1.14
	>=dev-python/configobj-5.0.6
"

DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}/avoid-to-use-print-statement-for-py3k.patch"
	distutils_src_compile
}

src_compile() {
	distutils_src_compile
}

src_install () {
	distutils_src_install
}
