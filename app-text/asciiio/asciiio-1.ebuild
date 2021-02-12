# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="No nonsense asciicasting for serious hackers"
HOMEPAGE="http://ascii.io"
SRC_URI="https://raw.github.com/sickill/ascii.io-cli/master/bin/asciiio"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""

RDEPEND="
=dev-lang/python-2*
"

S="${WORKDIR}"

src_unpack(){
	cp ${DISTDIR}/asciiio ${S}
}

src_compile(){
	sed 's/#\!\/usr\/bin\/env python/#\!\/usr\/bin\/python2/g' -i asciiio
}

src_install(){
	exeinto /usr/bin
	doexe  asciiio
}
