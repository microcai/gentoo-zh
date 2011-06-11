# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

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
	elog "Sample usage:"
	elog "$ groff-utf8 -Tutf8 -mandoc find.vi.1 | less"
	elog "$ groff-utf8 -Thtml -mandoc find.vi.1 > find.html; mozilla find.html"
	elog
	elog "You can also modify the TROFF/NROFF settings in your /etc/man.conf"
	elog "to make it use groff-utf8 instead of groff."
	elog "For example:"
	elog "NROFF       /usr/bin/groff-utf8 -Tutf8 -c -mandoc"
	elog
	elog "The whole idea is only a workaround. The ideal solution is to merge"
	elog "this package with groff, maybe sometime in the future. "
}
