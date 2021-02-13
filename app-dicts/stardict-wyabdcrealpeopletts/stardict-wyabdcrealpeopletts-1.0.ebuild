# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

IUSE=""

S=${WORKDIR}/WyabdcRealPeopleTTS

DESCRIPTION=""
SRC_URI="http://stardict-3.googlecode.com/files/WyabdcRealPeopleTTS.tar.bz2"
HOMEPAGE="http://code.google.com/p/stardict-3/"

SLOT="0"
LICENSE="GPL"
KEYWORDS="amd64 x86 ppc sparc alpha hppa"

DEPEND=""

src_unpack() {
	unpack ${A}
}
src_install() {
	mkdir -p ${D}/usr/share
	cp -r ${S} ${D}/usr/share
}
