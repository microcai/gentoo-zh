# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:$

inherit distutils

MY_PN="ZSI"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Web Services for Python"
HOMEPAGE="http://pywebsvcs.sourceforge.net/zsi.html"
SRC_URI="mirror://sourceforge/pywebsvcs/${MY_P}.tar.gz"

KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc-macos ~sparc ~x86 ~x86-fbsd"
SLOT="0"
LICENSE="PYTHON"
IUSE="examples doc twisted"

DEPEND=">=dev-python/pyxml-0.8.3
		>=dev-python/setuptools-0.6_rc3
		twisted?(
			>=dev-python/twisted-2.0
			>=dev-python/twisted-web-0.5.0
			>=dev-lang/python-2.4
			)"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}
PYTHON_MODNAME=${MY_PN}
DOCS="README CHANGES"

src_unpack() {
	unpack ${A}
	cd "${S}"
	if ! use twisted ; then
		sed -i \
			-e "/version_info/d"\
			-e "/ZSI.twisted/d"\
			setup.py
	fi
}

src_install() {
	distutils_src_install
	if use doc ; then
		dohtml doc/*.html doc/*.css doc/*.png
	fi
	if use examples ; then
		insinto "${ROOT}"/usr/share/doc/${PF}/examples
		doins -r doc/examples/* samples/*
	fi
}

