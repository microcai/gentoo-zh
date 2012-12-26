# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

IUSE=""

S=${WORKDIR}/WyabdcRealPeopleTTS

DESCRIPTION=""
SRC_URI="http://umn.dl.sourceforge.net/sourceforge/stardict/WyabdcRealPeopleTTS.tar.bz2"
HOMEPAGE="http://stardict.sourceforge.net/"

SLOT="0"
LICENSE="GPL"
KEYWORDS="x86 ppc sparc alpha hppa"

DEPEND="app-text/stardict"

src_unpack() {
	unpack ${A}
}
src_install() {
	mkdir -p ${D}/usr/share
	cp -r ${S} ${D}/usr/share
}
