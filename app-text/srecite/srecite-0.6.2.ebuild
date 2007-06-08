#Copyright
#Distributed under the terms of the GNU General Public License v2
#$Header: Exp $

inherit eutils

DESCRIPTION="Smart Reciting"
HOMEPAGE="http://srecite.sourceforge.net"
SRC_URI="mirror://sourceforge/srecite/${P}.tar.gz"
RESTRICT="nomirror"
LICENSE="GPL-2"
KEYWORDS="~x86 amd64 ia64 alpha ppc sparc hppa"

DEPEND=">=x11-libs/gtk+-2"

src_unpack(){
	unpack ${A}
	cd ${S}/src
	epatch ${FILESDIR}/srecite.rc.patch
}

src_install() {
	cd ${S}
	einstall || die "install failed"
}

