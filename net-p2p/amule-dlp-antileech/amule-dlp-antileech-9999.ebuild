# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit autotools git-r3 wxwidgets
DESCRIPTION="$PN, dynamic DLP library for amule-dlp"
HOMEPAGE="https://github.com/persmule/amule-dlp.antileech"
EGIT_REPO_URI="https://github.com/persmule/amule-dlp.antiLeech.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="X"

DEPEND="x11-libs/wxGTK:3.0"
RDEPEND="net-p2p/amule-dlp[dynamic]"
S=${WORKDIR}/amule-dlp.antileech

src_prepare() {
	eautoreconf || die
}

src_configure() {
	WX_GTK_VER="3.0"

	if use X; then
		einfo "wxGTK with X / GTK support will be used"
		need-wxwidgets unicode
	else
		einfo "wxGTK without X support will be used"
		need-wxwidgets base-unicode
	fi

	econf
}

src_install() {
	emake DESTDIR="${D}" install || die
}
