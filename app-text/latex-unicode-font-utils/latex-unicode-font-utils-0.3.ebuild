# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Latex unicode font utils"
HOMEPAGE="http://www.lidaibin.com"
SRC_URI="http://lidaibin.googlepages.com/${P}.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="local"

DEPEND="app-text/tetex
		app-text/dvipdfmx
		app-text/t1utils
		app-text/ttf2pt1
		dev-tex/cjk-latex"
RDEPEND="${DEPEND}"

RESTRICT="primaryuri"

src_unpack() {
	unpack ${P}.tbz2
}

src_install() {
	cd ${WORKDIR}
	if use local; then
		dobin texmf-local/cvtfont.sh
		dobin texmf-local/instfonts.sh
	else
		dobin texmf-home/cvtfont.sh
		dobin texmf-home/instfonts.sh
	fi
	insinto /etc
	doins font_maps.dat
	insinto /usr/share/${PN}
	doins UTF8-UCS2
	doins Unicode.sfd
}

pkg_postinst() {
	einfo
	einfo
	einfo "Please modify /etc/font_maps.dat before run instfonts.sh."
	einfo
	einfo "Usage: instfonts.sh <font-directory>"
	einfo "Example: instfonts.sh /usr/share/fonts/zh_CN"
	einfo
	einfo "How to make a pdf: "
	einfo "latex xxx.tex"
	einfo "dvipdfmx -v xxx.dvi"
	einfo
	einfo "Good luck"
	einfo
	einfo
}
