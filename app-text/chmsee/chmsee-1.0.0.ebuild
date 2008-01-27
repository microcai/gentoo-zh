# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils flag-o-matic

DESCRIPTION="Utility for viewing Microsoft .chm files."
HOMEPAGE="http://chmsee.gro.clinux.org"
SRC_URI="http://gro.clinux.org/frs/download.php/2040/${P}.tar.gz"
RESTRICT="primaryuri"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

IUSE="firefox"
RDEPEND=">=gnome-base/libglade-2.0
		 >=x11-libs/gtk+-2.8
		 app-doc/chmlib
		 dev-libs/openssl
		 firefox? ( >=www-client/mozilla-firefox-1.5.0.7 )
		 !firefox? ( >=www-client/seamonkey-1.0.7 )"
		 
DEPEND="${RDEPEND}"

src_compile() {
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR=${D} install || die
	dodoc COPYING AUTHORS README
}
