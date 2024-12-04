# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="An open-source Chinese font derived from IPAmj Mincho"
HOMEPAGE="https://github.com/lxgw/LxgwNeoZhiSong"
SRC_URI="
	https://github.com/lxgw/LxgwNeoZhiSong/releases/download/v${PV}/LXGWNeoZhiSong.ttf
"
S="${DISTDIR}"
LICENSE="IPAfont"
SLOT="0"
KEYWORDS="~amd64 ~loong ~riscv ~x86"

# Has to fall back to distdir until author offers tarball
FONT_SUFFIX="ttf"
FONT_S="${DISTDIR}"
