# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit autotools git-2
DESCRIPTION="$PN, dynamic DLP library for amule-dlp"
HOMEPAGE="https://github.com/persmule/amule-dlp.antileech"
EGIT_REPO_URI="git://github.com/persmule/amule-dlp.antiLeech.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=">=x11-libs/wxGTK-2.8.12:2.8"
RDEPEND="net-p2p/amule-dlp[dynamic]"
S=${WORKDIR}/amule-dlp.antileech

src_prepare() {
	eautoreconf || die
}

src_install() {
	emake DESTDIR="${D}" install || die
}
