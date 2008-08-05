# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Fun Input Toy for Linux"
HOMEPAGE="http://code.google.com/p/fitx"

RESTRICT="mirror"
MY_P=${PN}_${PV}
SRC_URI="http://fitx.googlecode.com/files/${MY_P}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="app-i18n/scim
	app-i18n/scim-python
	gnustep-base/gnustep-make
	gnustep-base/gnustep-base
	dev-db/sqlite
	virtual/libiconv
	"
RDEPEND=""

src_unpack() {
	einfo "Unpacking packages"
	unpack ${A}
	mv "${WORKDIR}/${PN}"  "${WORKDIR}/${P}"
}

src_compile() {
	#hould the build use multiprocessing? Not enabled by default, as it tends to break
	export MAKEOPTS="-j1"

	einfo "Compiling packages"
	. /usr/GNUstep/System/Library/Makefiles/GNUstep.sh
	emake || die "Make fail"
	epause 3
}

src_install() {
	einfo "Install fitx"
	emake DESTDIR="${D}" install
}
