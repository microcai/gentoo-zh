# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs flag-o-matic

DESCRIPTION="A small 'net top' tool, grouping bandwidth by process"
HOMEPAGE="https://github.com/raboof/nethogs"
MY_P=${P#lib}
SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ia64 ~x86"

RDEPEND="
	net-libs/libpcap
	sys-libs/ncurses:0=
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"
S="${WORKDIR}/${MY_P}"

src_compile() {
	tc-export CC CXX
	append-flags "-fPIC"
	emake NCURSES_LIBS="$( $(tc-getPKG_CONFIG) --libs ncurses )" ${PN}
}

src_install() {
#	sed -i '/-C\ doc/d' Makefile
#	sed -i '/ldconfig/d' src/MakeLib.mk
#	emake DESTDIR="${ED}" PREFIX="/usr" install_dev
	dolib src/${PN}.so.${PV}
	doheader src/${PN}.h

	dosym ${PN}.so.${PV} /usr/$(get_libdir)/${PN}.so
}
