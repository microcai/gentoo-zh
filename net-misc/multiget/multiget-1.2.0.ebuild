# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="A multi thread download tool liked flashget based wxGTK"
HOMEPAGE="http://sourceforge.net/projects/multiget"
SRC_URI="mirror://sourceforge/multiget/${P}.src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND=">=x11-libs/wxGTK-2.8.7.1-r1 !net-misc/multiget-bin"
RDEPEND="${DEPEND}"

RESTRICT="primaryuri"

S=${WORKDIR}/${PN}

src_compile() {
	cd ${S}
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	cd ${S}
	emake DESTDIR="${D}" install || die "install failed"
	insinto /usr/share/applications
	doins ${FILESDIR}/multiget.desktop
	insinto /usr/share/pixmaps
	doins ${FILESDIR}/multiget.png
}
