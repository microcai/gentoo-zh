# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils flag-o-matic

MY_P=${P/_beta/-beta}

DESCRIPTION="Utility for viewing Microsoft .chm files."
HOMEPAGE="http://chmsee.gro.clinux.org"
SRC_URI="http://chmsee.gro.clinux.org/${MY_P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

IUSE="css"
RDEPEND=">=gnome-base/libglade-2.0
		 >=x11-libs/gtk+-2.8
		 app-doc/chmlib
		 dev-libs/openssl"
		 
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf || die "configure failed"
	emake -j1 || die "make failed"
}

src_install() {
	einstall || die
	dodoc COPYING AUTHORS README
}
