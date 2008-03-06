# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

inherit eutils

DESCRIPTION="Console version of stardict, cross-platform and international dictionary."
HOMEPAGE="http://sdcv.sourceforge.net/"
SRC_URI="mirror://sourceforge/sdcv/${P}.tar.bz2"

RESTRICT="test mirror"
LICENSE="GPL-2"
SLOT="0"
# when adding keywords, remember to add to stardict.eclass
KEYWORDS="~x86"

RDEPEND=">app-dicts/stardict-3.0"

src_compile() {
	econf
	emake || die "compile problem"
}

src_install() {
	emake install DESTDIR="${D}" || die
}
