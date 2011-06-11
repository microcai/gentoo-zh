# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/media-fonts/wangttf/wangttf-1.3.ebuild,v 1.8 2006/05/27 11:45:49 palatis Exp $

inherit font

DESCRIPTION="Chinese TrueType and Type1 fonts from Dr. Hann-Tzong Wang"
HOMEPAGE="ftp://cle.linux.org.tw/pub2/fonts/wangfonts/"

BASE_SRC_URI="ftp://cle.linux.org.tw/pub2/fonts/wangfonts/"
MISC_SRC_URI="
	${BASE_SRC_URI}/COPYING
	${BASE_SRC_URI}/Changes.txt
	${BASE_SRC_URI}/README.b5
	${BASE_SRC_URI}/FOP-wangnew.tar.gz
	${BASE_SRC_URI}/WCL/Changes-WCL.txt
	${BASE_SRC_URI}/WCL/FOP-wcl.tar.gz"
TTF_SRC_URI="
	${BASE_SRC_URI}/wp010-05.ttf
	${BASE_SRC_URI}/wp010-08.ttf
	${BASE_SRC_URI}/wp110-05.ttf
	${BASE_SRC_URI}/wp110-08.ttf
	${BASE_SRC_URI}/wp210-05.ttf
	${BASE_SRC_URI}/wp210-08.ttf
	${BASE_SRC_URI}/wp310-05.ttf
	${BASE_SRC_URI}/wp310-08.ttf
	${BASE_SRC_URI}/wt001.ttf
	${BASE_SRC_URI}/wt002.ttf
	${BASE_SRC_URI}/wt003.ttf
	${BASE_SRC_URI}/wt004.ttf
	${BASE_SRC_URI}/wt005.ttf
	${BASE_SRC_URI}/wt006.ttf
	${BASE_SRC_URI}/wt009.ttf
	${BASE_SRC_URI}/wt011.ttf
	${BASE_SRC_URI}/wt014.ttf
	${BASE_SRC_URI}/wt021.ttf
	${BASE_SRC_URI}/wt024.ttf
	${BASE_SRC_URI}/wt028.ttf
	${BASE_SRC_URI}/wt034.ttf
	${BASE_SRC_URI}/wt040.ttf
	${BASE_SRC_URI}/wt064.ttf
	${BASE_SRC_URI}/wt071.ttf
	${BASE_SRC_URI}/wtcc02.ttf
	${BASE_SRC_URI}/wtcc15.ttf
	${BASE_SRC_URI}/wtg-06cut1x.ttf
	${BASE_SRC_URI}/wthc06.ttf
	${BASE_SRC_URI}/wts11.ttf
	${BASE_SRC_URI}/wts43.ttf
	${BASE_SRC_URI}/wts47.ttf
	${BASE_SRC_URI}/wts55.ttf
	${BASE_SRC_URI}/WCL/WCL-01.ttf
	${BASE_SRC_URI}/WCL/WCL-02.ttf
	${BASE_SRC_URI}/WCL/WCL-03.ttf
	${BASE_SRC_URI}/WCL/WCL-04.ttf
	${BASE_SRC_URI}/WCL/WCL-05.ttf
	${BASE_SRC_URI}/WCL/WCL-06.ttf
	${BASE_SRC_URI}/WCL/WCL-07.ttf
	${BASE_SRC_URI}/WCL/WCL-08.ttf
	${BASE_SRC_URI}/WCL/WCL-09.ttf
	${BASE_SRC_URI}/WCL/WCL-10.ttf"

SRC_URI="
	${MISC_SRC_URI}
	${TTF_SRC_URI}"

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

src_compile() {
	return
}
