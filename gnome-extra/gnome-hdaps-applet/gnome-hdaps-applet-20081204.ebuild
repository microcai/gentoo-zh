# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs

DESCRIPTION="Gnome applet displaying the hard disk protection status"
HOMEPAGE="http://www.zen24593.zen.co.uk/hdaps"
SRC_URI="${HOMEPAGE}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="app-laptop/hdapsd"
DEPEND="${DEPEND}
	virtual/pkgconfig
	gnome-base/gnome-panel"

S=${WORKDIR}
RESTRICT="primaryuri"

src_compile() {
	$(tc-getCC) ${CFLAGS} $(pkg-config --cflags --libs libpanelapplet-2.0) \
		-o gnome-hdaps-applet gnome-hdaps-applet.c || die "compile failed"
}

src_install() {
	exeinto /usr/libexec
	doexe gnome-hdaps-applet || die "doexe failed"

	insinto /usr/share/pixmaps/${PN}
	doins *.png || die "doins failed"

	insinto /usr/lib/bonobo/servers
	doins *.server || die "doins failed"

	dosed 's:\(location=\)\"\(gnome-hdaps-applet\)\":\1\"/usr/libexec/\2\":' \
		/usr/lib/bonobo/servers/GNOME_HDAPS_StatusApplet.server
}
