# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils flag-o-matic

DESCRIPTION="Utility for viewing Microsoft .chm files."
HOMEPAGE="http://chmsee.gro.clinux.org"
SRC_URI="http://chmsee.gro.clinux.org/${PN}-1.0.0-alpha.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

IUSE="css"
RDEPEND=">=gnome-base/libglade-2.0
		 >=x11-libs/gtk+-2.8
		 net-libs/gecko-sdk
		 app-doc/chmlib
		 dev-libs/openssl
		 "
		 
DEPEND="${RDEPEND}"

src_compile() {
	cd ${WORKDIR}/${PN}-1.0.0-alpha
    econf || die "configure failed"
    emake || die "make failed"
}

src_install() {
	cd ${WORKDIR}/${PN}-1.0.0-alpha
    einstall || die
    dodoc COPYING AUTHORS README
}
