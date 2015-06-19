# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $


EAPI="4"

inherit font

DESCRIPTION="Free Chinese TrueType fonts donated by Prof. Hann-Tzong Wang"
HOMEPAGE="https://code.google.com/p/wangfonts/"
SRC_URI="https://wangfonts.googlecode.com/files/${P}.tar.gz"

RESTRICT="mirror strip binchecks"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc mips ~s390 ~sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}"
FONT_S="${S}"
FONT_SUFFIX="ttf"
