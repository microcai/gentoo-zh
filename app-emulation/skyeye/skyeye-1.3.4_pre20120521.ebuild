# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils libtool autotools

DESCRIPTION="an ARM embedded hardware simulator"
HOMEPAGE="http://www.skyeye.org/"
SRC_URI="http://gentoo-china-overlay.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	media-libs/freetype
	sys-libs/ncurses
	x11-libs/gtk+:2
	x11-libs/pango"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( ChangeLog README TODO )

pkg_setup(){
	eerror "The CODE QULITY of ${PN} is _TOTALLY_ _SHIT_ , don't report any bug to the maintainer, please flood the upstream."
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-{iconv,arm,common,testsuite,utils,llvm,malloc}.patch
	eautoreconf
}

src_configure(){
	export CFLAGS="$CFLAGS -DPACKAGE=${PN} -DPACKAGE_VERSION=${PV}"
	econf 
}

pkg_postinst(){
	eerror "The CODE QULITY of ${PN} is _TOTALLY_ _SHIT_ , don't report any bug to the maintainer, please flood the upstream."
}
