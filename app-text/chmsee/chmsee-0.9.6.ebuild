# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils flag-o-matic

DESCRIPTION="Utility for viewing Microsoft .chm files."
HOMEPAGE="http://chmsee.gro.clinux.org"
SRC_URI="http://chmsee.gro.clinux.org/${P}.tar.bz2"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

IUSE=""
RDEPEND=">=dev-libs/glib-2.0
		 >=x11-libs/gtk+-2.2.4
		 >=gnome-extra/gtkhtml-3.2*"
		 
DEPEND="${RDEPEND}"

src_compile() {
        econf || die "configure failed"
        emake || die "make failed"
}

src_install() {
        einstall || die
        dodoc COPYING AUTHORS README
}
