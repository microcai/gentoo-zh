# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

inherit fdo-mime python

SRC_URI="https://${PN}.googlecode.com/files/${P}.tar.gz"

DESCRIPTION="An easy-to-use interface to the Xapian search engine"
HOMEPAGE="http://code.google.com/p/xappy"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/python-2.2
		dev-libs/xapian-bindings[python]"
DEPEND="${RDEPEND}"

pkg_setup() {
	python_set_active_version 2
}

src_install() {

	python setup.py install --root=${D} || die "Install failed"
}
