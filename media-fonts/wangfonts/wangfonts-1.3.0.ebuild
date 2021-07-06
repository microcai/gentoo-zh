# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
inherit font

DESCRIPTION="Free Chinese TrueType fonts donated by Prof. Hann-Tzong Wang"
HOMEPAGE="https://code.google.com/p/wangfonts/"
SRC_URI="https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/wangfonts/${P}.tar.gz"

RESTRICT="mirror strip binchecks"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 mips ppc ~s390 sparc x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}"
FONT_S="${S}"
FONT_SUFFIX="ttf"
