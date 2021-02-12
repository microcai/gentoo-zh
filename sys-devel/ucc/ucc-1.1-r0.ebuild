# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

inherit eutils

SOURCE="${PN}160.zip"
DESCRIPTION="UCC is an ANSI C Compiler"
HOMEPAGE="http://sourceforge.net/projects/ucc"
ECVS_CVS_OPTIONS="-dP -z3"
SRC_URI="mirror://sourceforge/ucc/${SOURCE}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

RESTRICT="mirror"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"
	mv ${PN} ${P}
	sed -i -e 's:/usr/local/lib/ucc/:/usr/lib/ucc/:' "${S}/driver/linux.c"
	sed -i -e 's:UCCDIR \"ucl\":\"/usr/bin/ucl\":' "${S}/driver/linux.c"
}

src_install() {
	dodir /usr/lib/ucc
	dodir /usr/bin
	dobin driver/ucc
	dobin ucl/ucl
	dodir	/usr/lib/ucc
	insinto /usr/lib/ucc
	doins ucl/assert.o
	dodir	/usr/include/ucc
	cp -r ucl/linux/include/* "${D}"/usr/include/ucc
}
