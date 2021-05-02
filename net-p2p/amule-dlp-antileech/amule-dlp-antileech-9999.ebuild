# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

WX_GTK_VER="3.0"
inherit autotools git-r3 wxwidgets
DESCRIPTION="$PN, dynamic DLP library for amule-dlp"
HOMEPAGE="https://github.com/persmule/amule-dlp.antileech"
EGIT_REPO_URI="https://github.com/persmule/amule-dlp.antiLeech.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="X"

DEPEND="x11-libs/wxGTK:${WX_GTK_VER}"
RDEPEND="net-p2p/amule-dlp[dynamic]"

src_prepare() {
	default
	eautoreconf || die
}

src_configure() {
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
