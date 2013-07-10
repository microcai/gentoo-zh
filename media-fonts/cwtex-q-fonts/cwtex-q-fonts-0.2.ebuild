# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit font-got

DESCRIPTION="Those five TrueType fonts are transformed from cwTeX Traditional Chinese Type 1 fonts(Version 1.1)."
HOMEPAGE="https://code.google.com/p/cwtex-q-fonts/"

SRC_BASE="http://cwtex-q-fonts.googlecode.com/svn-history/r36/trunk/ttf"

SRC_URI="
	${SRC_BASE}/cwTeXQFangsong-Medium.ttf
	${SRC_BASE}/cwTeXQHei-Bold.ttf
	${SRC_BASE}/cwTeXQKai-Medium.ttf
	${SRC_BASE}/cwTeXQMing-Medium.ttf
	${SRC_BASE}/cwTeXQYuan-Medium.ttf
"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="x86 amd64"

IUSE=""
DEPEND=""
S=${WORKDIR}
FONT_S="${S}"
FONT_SUFFIX="ttf"
RESTRICT="nostrip nomirror"

src_unpack()
{
	cd ${DISTDIR}
	cp ${A} ${S}
}
