# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $


inherit font

DESCRIPTION="Chinese TrueType and Type1 fonts from Dr. Hann-Tzong Wang"
HOMEPAGE="ftp://cle.linux.org.tw/pub2/fonts/wangfonts/"

BASE_SRC_URI="ftp://cle.linux.org.tw/pub2/fonts/wangfonts/"
SRC_URI="
	${BASE_SRC_URI}/wp010-05.ttf
	${BASE_SRC_URI}/wp010-08.ttf
	${BASE_SRC_URI}/wp110-05.ttf
	${BASE_SRC_URI}/wp110-08.ttf
	${BASE_SRC_URI}/wp210-05.ttf
	${BASE_SRC_URI}/wp210-08.ttf
	${BASE_SRC_URI}/wp310-05.ttf
	${BASE_SRC_URI}/wp310-08.ttf
	${BASE_SRC_URI}/wts11.ttf
	${BASE_SRC_URI}/wts43.ttf
	${BASE_SRC_URI}/wts47.ttf
	${BASE_SRC_URI}/wts55.ttf
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=""

S="${WORKDIR}"
FONT_S="${S}"
FONT_SUFFIX="ttf"
DOCS="
	COPYING
	Changes.txt
	README.b5
	FOP-wangnew.tar.gz
	Changes-WCL.txt
	FOP-wcl.tar.gz"

src_unpack() {
	cd ${DISTDIR}
	cp -g ${A} ${S}
}
