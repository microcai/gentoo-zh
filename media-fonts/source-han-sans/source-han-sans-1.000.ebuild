# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit font

MY_PN="SourceHanSansOTC"

DESCRIPTION="Source Han Sans is an OpenType/CFF Pan-CJK font family."
HOMEPAGE="https://github.com/adobe-fonts/source-han-sans"
SRC_URI="mirror://sourceforge/${PN}.adobe/${MY_PN}-${PV}.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc mips ~s390 ~sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"
FONT_S="${S}"
FONT_SUFFIX="ttc"

FONT_CONF=(
	${FILESDIR}/42-source-han-sans-sc-normal.conf
    ${FILESDIR}/42-source-han-sans-sc-regular.conf
	${FILESDIR}/42-source-han-sans-tc-normal.conf
    ${FILESDIR}/42-source-han-sans-tc-regular.conf
	${FILESDIR}/42-source-han-sans-j-normal.conf
    ${FILESDIR}/42-source-han-sans-j-regular.conf
	${FILESDIR}/42-source-han-sans-k-normal.conf
    ${FILESDIR}/42-source-han-sans-k-regular.conf
)

# Only installs fonts
RESTRICT="strip binchecks"

pkg_postinst() {
	unset FONT_CONF # override default message
	font_pkg_postinst
	elog
	elog "This font installs 8 fontconfig configuration files."
	elog
	elog "Include Simplified Chinese (sc), Traditional Chinese (tc),"
	elog "Japanese (j) and Korean (k)"
	elog
	elog 'Both Regular (regular) and Normal (normal) styles are available'
	elog "for each language."
	elog
	elog "To activate preferred rendering, run:"
	elog "eselect fontconfig enable 42-source-han-sans-(language)-(style).conf"
    elog
	elog "For example, run"
	elog "eselect fontconfig enable 42-source-han-sans-j-regular.conf"
	elog "to set Japanese with Regular style as the preferred font."
	elog
	elog "eselect fontconfig enable 42-source-han-sans-sc-normal.conf"
	elog "to set Simplified Chinese with Normal style as the preferred font."
	elog
	elog "You shouldn't enable two or more config at the same time."
	elog
}
