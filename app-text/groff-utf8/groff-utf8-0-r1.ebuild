# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="GNU groff wrapper allowing UTF-8 input"
HOMEPAGE="http://www.haible.de/bruno/packages-groff-utf8.html"
SRC_URI="http://www.haible.de/bruno/gnu/${PN}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

RESTRICT="mirror"

DEPEND=">=sys-apps/groff-1.18.1"

S="${WORKDIR}/${PN}"

src_install() {
	emake install DESTDIR="${D}" PREFIX=/usr || die "make install failed"
}

pkg_postinst() {
	sed	's/^NROFF.*\/usr\/bin\/nroff -mandoc/NROFF\t\t\/usr\/bin\/groff-utf8 -Tutf8 -c -mandoc/' -i /etc/man.conf
}

pkg_postrm(){
	sed	's/groff-utf8 -Tutf8 -c -mandoc/nroff -mandoc/g' -i /etc/man.conf
}
