# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Encode and decode base64 file"
HOMEPAGE="http://www.fourmilab.ch/webtools/base64"
SRC_URI="http://www.fourmilab.ch/webtools/{$PN}/${P}.tar.gz"

LICENSE="GPL"
KEYWORDS="alpha amd64 ~hppa ppc ppc64 sparc x86"
IUSE=""

src_compile() {
	econf || die "Error: econf failed!"
	emake || die "Error: emake failed!"
}

src_install() {
	dobin base64
	dodoc INSTALL README rfc1341.html rfc1341.txt
}
