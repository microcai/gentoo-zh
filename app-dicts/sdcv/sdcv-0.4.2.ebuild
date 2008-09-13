# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Console version of stardict, cross-platform and international dictionary."
HOMEPAGE="http://sdcv.sourceforge.net/"
SRC_URI="mirror://sourceforge/sdcv/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86" # when adding keywords, remember to add to stardict.eclass
IUSE=""

DEPEND="dev-util/pkgconfig"
RDEPEND=">app-dicts/stardict-3.0"

RESTRICT="test primaryuri"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-gcc-4.3.patch
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
}
