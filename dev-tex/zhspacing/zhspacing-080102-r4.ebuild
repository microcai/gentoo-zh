# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils xetex-package

ZHS_MANUAL="zhs-man071211.pdf"
DESCRIPTION="zhspacing fine-tunes several details in typesetting Chinese using XeTeX and XeLaTeX"
HOMEPAGE="http://code.google.com/p/zhspacing/"
SRC_URI="http://zhspacing.googlecode.com/files/${PN}${PV}.tar.bz2 -> ${P}.tar.bz2
	http://zhspacing.googlecode.com/files/${ZHS_MANUAL}"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

S=${WORKDIR}
RESTRICT="mirror"

DOCS="${FILESDIR}/example.tex"

# Because the einfo make backslash print very complecated.
# And different version of portage use different einfo/elog,
# which make the hacking even difficult,
# thus I use this easy version to print LaTeX text.
color_echo() {
	# color variable from portage
	# (Keep the variables as private as possible.)
	# http://overlays.gentoo.org/proj/sunrise/wiki/CodingStandards
	local GOOD=$'\e[32;01m' NORMAL=$'\e[0m'
	echo " ${GOOD}*${NORMAL} $@"
}

src_unpack() {
	unpack "${P}.tar.bz2"
	cp "${DISTDIR}/${ZHS_MANUAL}" "${S}"
}

src_install() {
	dodir /usr/share/texmf/doc/xetex/zhspacing
	xetex-package_src_install
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
	einfo "fonts in your Box. "
	einfo
	einfo "Suppose that you have Adobe Heiti Std, Adobe Kaiti Std, and Adobe Song Std "
	einfo "in your Gentoo, then set these lines in the preamble of your tex file,"
	einfo "which using zhpacing."
	einfo "we need load fontspec first, because we use the \\\\\\ \bnewfontfamily."
	einfo
	color_echo  "\"\\usepackage{fontspec}\""
	color_echo "\"\\newfontfamily\\zhfont[BoldFont=Adobe Heiti Std,ItalicFont=Adobe Kaiti Std]{Adobe Song Std}\""
	color_echo "\"\\newfontfamily\\zhpunctfont{Adobe Song Std}\""
	color_echo "\"\\usepackage{zhspacing}\""
	einfo
	einfo "Then zhspacing will use above fonts as default fonts."
	einfo
	einfo "You can find an example on this substitution"
	einfo "in the /usr/share/doc/${P} as well."
	einfo
	ewarn
	epause 10
}

pkg_postrm() {
	einfo "Running mktexlsr to rebuild ls-R database...."
	mktexlsr
}
