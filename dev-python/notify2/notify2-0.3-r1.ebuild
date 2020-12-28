# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Python interface to DBus notifications."
HOMEPAGE="https://bitbucket.org/takluyver/pynotify2"
SRC_URI="http://pypi.python.org/packages/source/n/notify2/notify2-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x64-macos"
IUSE="examples"

RDEPEND="dev-python/dbus-python[${PYTHON_USEDEP}]"

python_test() {
   python_execute_function testing
   "${PYTHON}" setup.py test || die
}

python_install_all() {
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*
	fi
	distutils-r1_python_install_all
}
