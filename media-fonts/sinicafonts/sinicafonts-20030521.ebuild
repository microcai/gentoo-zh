# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="7"

inherit font

DESCRIPTION="Chinese and Siddam fonts provided by SINICA, Taiwan."
HOMEPAGE="http://cdp.sinica.edu.tw/"

BASE_SRC_URI="http://linux3.cc.ntu.edu.tw/pub/CLE/pub2/fonts/sinica"
SRC_URI="
	${BASE_SRC_URI}/hzk1.ttf
	${BASE_SRC_URI}/hzk2.ttf
	${BASE_SRC_URI}/hzk3.ttf
	${BASE_SRC_URI}/hzk4.ttf
	${BASE_SRC_URI}/hzk5.ttf
	${BASE_SRC_URI}/hzk6.ttf
	${BASE_SRC_URI}/hzk7.ttf
	${BASE_SRC_URI}/hzk8.ttf
	${BASE_SRC_URI}/hzk9.ttf
	${BASE_SRC_URI}/hzka.ttf
	${BASE_SRC_URI}/hzkb.ttf
	${BASE_SRC_URI}/hzkc.ttf
	${BASE_SRC_URI}/siddam.zip"

RESTRICT="mirror strip binchecks"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc mips ~s390 ~sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}
FONT_S="${S}"
FONT_SUFFIX="ttf TTF"

src_unpack() {
	:;
}

src_install() {
	unpack siddam.zip
	cp ${DISTDIR}/*.ttf ./

	font_src_install
}
