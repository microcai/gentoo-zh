# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

inherit eutils

DESCRIPTION="Smart Reciting"
HOMEPAGE="http://srecite.sourceforge.net"
SRC_URI="mirror://sourceforge/srecite/${P}.tar.gz"
RESTRICT="mirror"
LICENSE="GPL-2"
KEYWORDS="~x86 amd64 ia64 alpha ppc sparc hppa"
SLOT="0"

DEPEND=">=x11-libs/gtk+-2"

src_unpack(){
	unpack ${A}
	cd "${S}/src"
	epatch "${FILESDIR}/srecite.rc.patch"
}

src_install() {
	einstall || die "install failed"
}
