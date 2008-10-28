# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit xetex-package

DESCRIPTION="zhspacing fine-tunes several details in typesetting Chinese using XeTeX and XeLaTeX"
HOMEPAGE="http://code.google.com/p/zhspacing/"
SRC_URI="http://zhspacing.googlecode.com/files/${PN}${PV}.tar.bz2
	http://zhspacing.googlecode.com/files/zhs-man071211.pdf"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

RESTRICT="mirror"

S=${WORKDIR}
src_unpack() {
	unpack "${PN}${PV}.tar.bz2"
	cp "${DISTDIR}"/*.pdf "${S}/"
}

pkg_postinst() {
	einfo "Running mktexlsr to rebuild ls-R database...."
	mktexlsr
	ewarn
	ewarn "Notice this!"
	ewarn
	ewarn "Zhspacing use SimSun, SimHei, FangSong, and KaiTi_GB2312"
	ewarn "as default Chinese fonts."
	ewarn "If you don't have these fonts in your Gentoo Box, you will"
	ewarn "encounter compiling error while using zhspacing."
	ewarn
	einfo "You can choose to find those fonts and put them into your Box,"
	einfo "or use below trick to substitute them to the existing"
	einfo "fonts in your Box."
	einfo
	einfo "E.g., if you want use FZShuSong to substitute SimSun, do these:"
	einfo
	einfo "First, check result:"
	einfo "\"sed -n 's/SimSun/FZShuSong/p' /usr/share/texmf/tex/xetex/zhspacing/*.sty | grep FZShuSong\""
	einfo
	einfo "If it is correct, then"
	einfo "\"sed -i 's/SimSun/FZShuSong/' /usr/share/texmf/tex/xetex/zhspacing/*.sty\""
	einfo
	einfo "At this point the Default Chinese Roman Font (Serif), which"
	einfo "Zhspacing used is been changed from SimSun to FZShuSong. "
	einfo "Repeat these steps for SimHei, FangSong, and KaiTi_GB2312, if you need."
	einfo
	ewarn
	epause 10

}

pkg_postrm() {
	einfo "Running mktexlsr to rebuild ls-R database...."
	mktexlsr
}
