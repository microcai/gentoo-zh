# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Real People Sound"
HOMEPAGE="http://sourceforge.net/projects/stardict/"
SRC_URI="mirror://sourceforge/stardict/${PN}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=""
RESTRICT="mirror"

src_unpack() {
	unpack ${PN}.tar.bz2
}

src_install() {
	dodir /usr/share/${PN}
	cd "${WORKDIR}"/${PN}
	for SUBDIR in *
	do
		if [ -d $SUBDIR ]
		then
			dodir /usr/share/${PN}/$SUBDIR
			insinto /usr/share/${PN}/$SUBDIR
			doins $SUBDIR/*.wav
		fi
	done
}

