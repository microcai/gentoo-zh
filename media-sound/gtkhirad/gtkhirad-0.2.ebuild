# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="A desktop utility for Hinet Radio"
HOMEPAGE="http://pcman.sayya.org/gtkhirad/"
SRC_URI="http://pcman.sayya.org/gtkhirad/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~x86"
RESTRICT="nomirror"

DEPEND="=x11-libs/gtk+-2*
	sys-apps/sed
	sys-apps/grep
	dev-lang/perl
	media-video/mplayer"
src_unpack() {
	unpack ${A}
	cd ${S}
	# apply gcc34 patch
	epatch ${FILESDIR}/gtkhirad-0.2-sandbox.patch
}

src_install() {
	dodir /usr/bin
	dodir /usr/lib/gtkhirad
	dodir /usr/share/applications/
	dodir /usr/share/pixmaps
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc README
}
