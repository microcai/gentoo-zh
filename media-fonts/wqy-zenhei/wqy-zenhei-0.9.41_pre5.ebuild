# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit font

DESCRIPTION="WenQuanYi Hei-Ti Style (sans-serif) Chinese outline font"
HOMEPAGE="http://wqy.sourceforge.net/cgi-bin/enindex.cgi?ZenHei(en)"
SRC_URI="mirror://sourceforge/wqy/${P/_pre5/-May}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

FONT_S=${WORKDIR}/${PN}
S=${FONT_S}
FONT_CONF=(
	"44-wqy-zenhei.conf"
	"66-wqy-zenhei-sharp.conf"
	"66-wqy-zenhei-sharp-no13px.conf"
)
FONT_SUFFIX="ttc"
DOCS="WQY_ZENHEI_MONTHLY_BUILD"
