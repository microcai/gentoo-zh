# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils flag-o-matic

DESCRIPTION="Library to deal with DWARF Debugging Information Format"
HOMEPAGE="https://github.com/Distrotech/libdwarf"
SRC_URI="https://github.com/Distrotech/${PN}/archive/${PV}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}/${PN}"

# dirty hack, since I can't properly patch buildsystem
QA_PREBUILT="*/${PN}.so"

src_configure() {
	econf --enable-shared
}

src_install() {
	use static-libs && dolib.a libdwarf.a
	dolib.so libdwarf.so

	insinto /usr/include
	doins libdwarf.h

	dodoc NEWS README CHANGES
}
