# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="ncurses-based ssh multiplexer for cluster administration"

HOMEPAGE="http://omnitty.sourceforge.net/"
SRC_URI="mirror://sourceforge/omnitty/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="virtual/libc
	sys-libs/ncurses
	dev-libs/rote
	sys-devel/autoconf"
RDEPEND="virtual/libc
	sys-libs/ncurses
	dev-libs/rote
	virtual/ssh"

src_compile() {
		econf || die "configure failed";
			emake || die "make failed";
}

src_install() {
		einstall || die "install failed";
}
