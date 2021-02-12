# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

inherit eutils


DESCRIPTION="Create X menus from the shell"
HOMEPAGE="http://packages.debian.org/source/sid/9menu"
SRC_URI="mirror://debian/pool/main/9/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/libX11"


src_compile() {
	emake -f Makefile.noimake || die "emake error"
}

src_install() {
	dobin 9menu
	doman ${PN}.1
	dodoc README
}
