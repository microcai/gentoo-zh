# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs eutils

DESCRIPTION="A LALR(1) parser generator."
HOMEPAGE="http://www.hwaci.com/sw/lemon/"
SRC_URI="http://www.sqlite.org/sqlite-${PV}.tar.gz"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

S=${WORKDIR}/sqlite-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}/tool/
	epatch "$FILESDIR/lemon.patch"
}

src_compile() {
	cd ${S}/tool/
	"$(tc-getCC)" -o lemon lemon.c || die
}

src_install() {
	cd ${S}/tool/
	dodir /usr/share/lemon/
	insinto /usr/share/lemon/
	doins lempar.c
	dobin lemon
}
