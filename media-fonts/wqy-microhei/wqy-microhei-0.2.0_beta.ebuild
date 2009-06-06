# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# Based on wqy-microhei-0.2-beta.exheres from Exherbo Linux.
# which is
# Copyright 2008,2009 Hong Hao  <oahong@gmail.com>

inherit font

DESCRIPTION="Sans-Serif style high quality CJK outline font derived from \"Droid Sans Fallback\""
HOMEPAGE="http://wenq.org/enindex.cgi?action=browse&id=MicroHei(en)"
SRC_URI="mirror://sourceforge/wqy/${P/_/-}.tar.gz"

LICENSE="|| ( GPL-3 Apache-2.0 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

FONT_S=${WORKDIR}/${PN}
S=${FONT_S}
FONT_SUFFIX="ttc"
