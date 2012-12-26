# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
inherit distutils python

DESCRIPTION="Python Video 4 Linux extension module developed in C"
HOMEPAGE="http://members.optushome.com.au/pythondeveloper/programming/python/pyv4l"
SRC_URI="http://members.optushome.com.au/pythondeveloper/programming/python/pyv4l/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-lang/python"
RDEPEND="${DEPEND}"

RESTRICT="primaryuri"
