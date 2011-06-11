# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/media-fonts/cwttf/cwttf-1.0.ebuild,v 1.2 2006/05/27 11:40:24 palatis Exp $

inherit font-got

DESCRIPTION="Those five TrueType fonts are transformed from cwTeX Traditional Chinese Type 1 fonts, and merge Alexej Kryukov's CM-LGC font and Koanughi Un's Un-Fonts."
HOMEPAGE="http://cle.linux.org.tw/fonts/cwttf"

SRC_BASE="http://cle.linux.org.tw/fonts/cwttf"
TTF_TYPE="center/"

SRC_URI="http://cle.linux.org.tw/fonts/${PN}/${P/-/-v}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="x86 amd64"

IUSE="cwttf-baseline cwttf-center"
DEPEND=""
S=${WORKDIR}/${PN}
FONT_S="${S}"
FONT_SUFFIX="ttf"
DOCS="AUTHORS COPYING Changes-big5.txt Changes-en.txt Readme-big5.cwttf Readme-en.cwttf Readme.cm-lgc Readme.un-fonts"
RESTRICT="nostrip nomirror"

src_unpack()
{
	unpack ${A}
	cd ${S}
	rename .ttf -b.ttf baseline/*.ttf
	rename .ttf -c.ttf center/*.ttf
	
	use cwttf-baseline && mv baseline/*.ttf .
	use cwttf-center && mv center/*.ttf .
	
	use cwttf-baseline || use cwttf-center || {
		eerror
		eerror "You must select at least one USE of cwttf-baseline and cwttf-center !!"
		eerror
		die 1
	}
}


