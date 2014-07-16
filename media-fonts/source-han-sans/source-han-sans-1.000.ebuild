# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit font

MY_PN="SourceHanSansOTF"

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
FONT_SUFFIX="otf"

FONT_CONF=(
	${FILESDIR}/42-source-han-sans-normal.conf
    ${FILESDIR}/42-source-han-sans-regular.conf
)

# Only installs fonts
RESTRICT="strip binchecks"

pkg_postinst() {
	unset FONT_CONF # override default message
	font_pkg_postinst
	elog
	elog "This font installs two fontconfig configuration files."
	elog
	elog "To activate preferred rendering, run:"
	elog "eselect fontconfig enable 42-source-han-sans-normal.conf"
	elog "or"
	elog "eselect fontconfig enable 42-source-han-sans-regular.conf"
	elog "(don't enable them at the same time)"
	elog
}
