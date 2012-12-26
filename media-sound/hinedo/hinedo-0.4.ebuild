# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="A desktop utility for Hinet Radio"
HOMEPAGE="http://hinedo.openfoundry.org/"
SRC_URI="http://hydonsingore.myweb.hinet.net/mirror/hinedo/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
RESTRICT="nomirror"
SLOT="0"
DEPEND="=x11-libs/gtk+-2*
	dev-lang/python
	media-video/mplayer"
src_unpack() {
	unpack ${A}
	cd ${S}
}

src_install() {
	dodir /usr/bin
	dodir /usr/lib/gtkhirad
	dodir /usr/share/applications
	dodir /usr/share/pixmaps
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc README
}
