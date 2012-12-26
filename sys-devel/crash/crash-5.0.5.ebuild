# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="Tool to investigate kernel core dumps"
HOMEPAGE="http://people.redhat.com/anderson/"
SRC_URI="http://people.redhat.com/anderson/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e 's#\(/usr/bin/install\)\(.*\)#\1 -D\2/${PROGRAM}#' Makefile
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README || die
}
