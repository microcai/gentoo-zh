# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION=" A malloc(3) debugger"
HOMEPAGE="http://perens.com/FreeSoftware/ElectricFence/"
SRC_URI="http://perens.com/FreeSoftware/ElectricFence/${PN}_${PVR/_pre/-0.}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

MY_P=${P/_pre1/}
S=${WORKDIR}/${MY_P}

src_compile() {
	emake || die "emake failed"
	gcc -g -shared -Wl,-soname,libefence.so.0 -o libefence.so.0.0 efence.o page.o print.o -lc -lpthread \
		|| die "generating libefence.so failed"
}

src_install() {
	dolib.a libefence.a
	dolib.so libefence.so.0.0
	dosym libefence.so.0.0 /usr/lib/libefence.so.0
	dosym libefence.so.0.0 /usr/lib/libefence.so
	doman libefence.3
	dodoc README debian/README.gdb
}
