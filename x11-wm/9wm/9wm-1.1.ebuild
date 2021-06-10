# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

inherit eutils

DESCRIPTION="A window manager emulation of the Plan 9 window manager 8-1/2."
HOMEPAGE="http://unauthorised.org/dhog/9wm.html"
SRC_URI="http://unauthorised.org/dhog/9wm/9wm-1.1.tar.gz"

LICENSE="9wm"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-terms/xterm"

src_compile() {
	emake -f Makefile.no-imake || die "emake error"
}

src_install() {
	dobin "${PN}"
	mv "${PN}.man" "${PN}.1"
	doman "${PN}.1"
	dodoc README
}
