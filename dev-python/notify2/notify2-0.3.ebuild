# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-twitter/python-twitter-0.8.5.ebuild,v 1.1 2013/02/22 05:42:09 patrick Exp $

EAPI="5"
PYTHON_DEPEND="2 3"
SUPPORT_PYTHON_ABIS="1"
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit distutils

DESCRIPTION="Python interface to DBus notifications."
HOMEPAGE="https://bitbucket.org/takluyver/pynotify2"
SRC_URI="http://pypi.python.org/packages/source/n/notify2/notify2-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x64-macos"
IUSE="examples"
PYTHON_MODNAME="notify2.py"

src_prepare() {
    distutils_src_prepare
}

src_test() {
   testing() {
       PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" test_notify2.py
   }
   python_execute_function testing
}

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*
	fi
}
