# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit font

DESCRIPTION="WenQuanYi TrueType CJK font"
HOMEPAGE="http://wqy.sourceforge.net/en/"
SRC_URI="mirror://sourceforge/wqy/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ~s390 ~sh ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""
S="${WORKDIR}/${PN}"
FONT_S="${S}"
FONT_CONF="44-wqy-zenhei.conf"

FONT_SUFFIX="ttf"
DOCS="AUTHORS ChangeLog COPYING INSTALL README"

# Only installs fonts
RESTRICT="strip binchecks mirror"
