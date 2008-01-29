# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Latex unicode font utils"
HOMEPAGE="http://www.lidaibin.com"
SRC_URI="http://lidaibin.googlepages.com/${P}.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/tetex
		>=app-text/dvipdfmx-20050201
		app-text/t1utils
		>=app-text/ttf2pt1-3.4.4
		dev-tex/cjk-latex"
RDEPEND="${DEPEND}"

RESTRICT="primaryuri"

src_unpack() {
	unpack ${P}.tbz2
}

src_install() {
	cd ${S}
	dobin cvtfont.local
	dobin instfonts.local
	dobin cvtfont.home
	dobin instfonts.home
	insinto /etc
	doins font_maps.dat
	insinto /usr/share/${PN}
	doins UTF8-UCS2
	doins Unicode.sfd
}

pkg_postinst() {
	einfo
	einfo
	einfo "Please modify /etc/font_maps.dat before run instfonts.*."
	einfo
	einfo "Usage: instfonts.<local/home> <font-directory>"
	einfo "Example: instfonts.<local/home> /usr/share/fonts/zh_CN"
	einfo
	einfo "instfonts.local generate configure files to /usr/local/share/texmf"
	einfo "instfonts.home generate configure files to \$HOME/texmf"
	einfo
	einfo "How to make a pdf: "
	einfo "latex xxx.tex"
	einfo "dvipdfmx -v xxx.dvi"
	einfo
	einfo "Good luck"
	einfo
	einfo
}
