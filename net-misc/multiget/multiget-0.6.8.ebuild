# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="A multi thread download tool liked flashget based wxGTK"
HOMEPAGE="http://sourceforge.net/projects/multiget"
SRC_URI="mirror://sourceforge/multiget/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="x11-libs/wxGTK"
RDEPEND="${DEPEND}"

RESTRICT="primaryuri"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/multiget_charset.patch
}

src_compile() {
	cd ${S}
	emake || die "make failed"
}

src_install() {
	cd ${S}
	dobin MultiGet
	insinto /usr/share/applications
	doins ${FILESDIR}/multiget.desktop
	insinto /usr/share/pixmaps
	doins ${FILESDIR}/multiget.png
}
