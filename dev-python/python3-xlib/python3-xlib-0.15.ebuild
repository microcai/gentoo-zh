# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python{3_3,3_4} )
SUPPORT_PYTHON_ABIS="1"

inherit distutils-r1

DESCRIPTION="python3 version of python-xlib"
HOMEPAGE="https://github.com/LiuLang/python3-xlib https://pypi.python.org/pypi/python3-xlib"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPLv2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
IUSE=""
RESTRICT="mirror"

RESTRICT_PYTHON_ABIS="3.*"

PYTHON_MODNAME="Xlib"


src_test() {
	cd test
	testing() {
		local return_status="0" test
		for test in *.py; do
			echo "Running ${test}..."
			PYTHONPATH="../build-${PYTHON_ABI}/lib" "$(PYTHON)" "${test}" || return_status="1"
		done
		return "${return_status}"
	}
	python_execute_function testing
}

