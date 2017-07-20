# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )
inherit fdo-mime python-single-r1

SRC_URI="https://${PN}.googlecode.com/files/${P}.tar.gz"
DESCRIPTION="An easy-to-use interface to the Xapian search engine"
HOMEPAGE="http://code.google.com/p/xappy"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${PYTHON_DEPS}
		dev-libs/xapian-bindings[python,${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

src_install() {
	"${PYTHON}" setup.py install --root=${D} || die "Install failed"
}
