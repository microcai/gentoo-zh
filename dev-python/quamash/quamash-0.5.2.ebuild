# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python3_{3,4} )
inherit distutils-r1

DESCRIPTION="Implementation of the PEP 3156 Event-Loop with Qt."
HOMEPAGE="http://pypi.python.org/pypi/quamash"
SRC_URI="mirror://pypi/Q/Quamash/Quamash-0.5.2.tar.gz"

MY_P="Quamash"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	( || ( || ( dev-python/PyQt4 dev-python/PyQt5 ) dev-python/PySide ) )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}-${PV}"

python_compile_all() {
	if use doc; then
		emake -C doc html
	fi
}

python_install_all() {
	use doc && local HTML_DOCS=doc/build/html/.
	disutils-r1_python_install_all
}


