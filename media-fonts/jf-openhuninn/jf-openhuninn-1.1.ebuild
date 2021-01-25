# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit font

DESCRIPTION="An opensource Chinese font by justfont, based on Kosugi Maru and Varela Round"
HOMEPAGE="https://justfont.com/huninn/"
SRC_URI="https://github.com/justfont/open-huninn-font/releases/download/v${PV}/jf-openhuninn-${PV}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"

FONT_SUFFIX="ttf"
