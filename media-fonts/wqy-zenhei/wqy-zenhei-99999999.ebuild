# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

inherit font

DESCRIPTION="WenQuanYi Hei-Ti Style (sans-serif) Chinese outline font"
HOMEPAGE="http://wqy.sourceforge.net/cgi-bin/enindex.cgi?ZenHei(en)"
SRC_URI="http://wenq.org/daily/zenhei/${P/99999999/0.9.34}-nightlybuild.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""

S=${WORKDIR}/${PN}
FONT_S=${S}
FONT_CONF=(	"44-wqy-zenhei.conf"
		"66-wqy-zenhei-sharp.conf"	)

FONT_SUFFIX="ttc"
DOCS="WQY_ZENHEI_NIGHTLY_BUILD"

pkg_postinst() {
	font_pkg_postinst
	ewarn "This is only a cutting-edge nightly build font. A shiny"
	ewarn "new WenQuanYi ZenHei mono font is included in this package."
	ewarn "For more information please take a look at:"
	ewarn "http://wenq.org/forum/viewtopic.php?t=699"
	echo
	elog "This font installs two fontconfig configuration files."
	elog ""
	elog "To activate preferred rendering, run:"
	elog "eselect fontconfig enable 44-wqy-zenhei.conf"
	elog
	elog "To make the font only use embedded bitmap fonts when available, run:"
	elog "eselect fontconfig enable 66-wqy-zenhei-sharp.conf"
	echo
}
