# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit autotools mercurial
DESCRIPTION="$PN, dynamic DLP library for amule-dlp"
HOMEPAGE="http://code.google.com/p/amule-dlp/"
EHG_REPO_URI="https://code.google.com/p/amule-dlp.antileech/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="net-p2p/amule-dlp[dynamic]"
S=${WORKDIR}/amule-dlp.antileech

src_prepare() {
	eautoreconf || die
}

src_install() {
	emake DESTDIR="${D}" install || die
}

