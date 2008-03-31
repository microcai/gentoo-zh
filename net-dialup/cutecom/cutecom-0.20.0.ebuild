# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

inherit eutils qt4 cmake-utils kde-functions

DESCRIPTION="CuteCom is a serial terminal, like minicom, written in qt"
HOMEPAGE="http://cutecom.sourceforge.net"
SRC_URI="http://cutecom.sourceforge.net/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RESTRICT="mirror"  #for overlay

DEPEND="$(qt4_min_version 4.2)"
RDEPEND="${DEPEND} \
	net-dialup/lrzsz"

src_compile() {
	cmake-utils_src_compile || die "src_compile fail"
}

src_install() {
	cmake-utils_src_install 
	dobin cutecom 
	dodoc README Changelog README
	make_desktop_entry cutecom "CuteCom" openterm
}


