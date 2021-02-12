# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="7"

inherit font

DESCRIPTION="Chinese Fonts from National Taiwan University, Includes kai, Lei, Funsong, and Thin."
HOMEPAGE="http://www.csie.ntu.edu.tw/"

BASE_SRC_URI="http://linux3.cc.ntu.edu.tw/pub/CLE/pub2/fonts/ttf/big5/ntu/"
SRC_URI="
	${BASE_SRC_URI}/NTU_FS_M.TTF
	${BASE_SRC_URI}/NTU_KAI.TTF
	${BASE_SRC_URI}/NTU_LI_M.TTF
	${BASE_SRC_URI}/NTU_MB.TTF
	${BASE_SRC_URI}/NTU_MM.TTF
	${BASE_SRC_URI}/NTU_MR.TTF
	${BASE_SRC_URI}/NTU_TW.TTF"

RESTRICT="mirror strip binchecks"

LICENSE="ntufonts"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc mips ~s390 ~sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

FONT_S="${S}"
FONT_SUFFIX="TTF"

src_unpack() {
	mkdir ${S}
}

src_prepare() {
	cp ${DISTDIR}/*.TTF ${S}
}

pkg_postinst() {
	font_pkg_postinst
	ewarn "These problematic legacy fonts were kept for their"
	ewarn "historical significance."
	ewarn
	ewarn "They are using BIG-5 instead of UTF-8 for the metadata."
	ewarn "They may trigger warnings or errors when some programs dealing"
	ewarn "with them. And you may see question marks, boxes, or other "
	ewarn "symbols (Mojibake) as the fonts name and other information."
	ewarn
	ewarn "USE AT YOUR OWN RISK."
}
