# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils
DESCRIPTION="gtk front-end of the p2p iptv"
HOMEPAGE="http://code.google.com/p/gsopcast"
SRC_URI="http://gsopcast.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="x11-libs/gtk+
	media-tv/sopcast"
RDEPEND="${DEPEND}
	amd64? ( app-emulation/emul-linux-x86-compat )"

RESTRICT="mirror"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gcc4.3.patch"
}

src_install() {
	make DESTDIR=${D} install
}

