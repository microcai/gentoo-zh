# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit flag-o-matic eutils

IUSE=""
DESCRIPTION="Library for Chinese Phonetic input method"
HOMEPAGE="http://chewing.csie.net/"
SRC_URI="http://chewing.csie.net/download/libchewing/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64"
DEPEND="virtual/libc"

#PATCHES=( "${FILESDIR}/libchewing-0.3.2.chewing_zuin.patch" )

src_compile() {
	econf || die "./configure failed"
	emake -j1 || die "make failed"
}

src_install() {
	make install DESTDIR="${D}" || die "install failed"
}
