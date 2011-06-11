# Copyright 1999-2010 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/app-dicts/stardict-wyabdcrealpeopletts/stardict-wyabdcrealpeopletts-1.0.ebuild,v 1.2 2007/02/12 06:34:49 scsi Exp $

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
