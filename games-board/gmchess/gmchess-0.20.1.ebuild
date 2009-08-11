# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games

DESCRIPTION="gmchess is an gtkmm implementation of Chinese chess"
HOMEPAGE="http://code.google.com/p/gmchess/"
SRC_URI="http://gmchess.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="nls"
RESTRICT="mirror"

DEPEND="dev-cpp/gtkmm"
RDEPEND="${DEPEND}"

src_compile() {

	econf \
	$(use_enable nls) \
	|| die "Error: econf failed!"
	
	emake || die "Error: emake failed!"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
}
