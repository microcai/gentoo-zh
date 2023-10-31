# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

MY_P="${PN}-v${PV}"

DESCRIPTION="An open-source Chinese font derived from Fontworks' Klee One"
HOMEPAGE="https://github.com/lxgw/LxgwNeoZhiSong"
SRC_URI="
	https://github.com/lxgw/LxgwNeoZhiSong/releases/download/v${PV}/LXGWNeoZhiSongCHS.ttf
	https://github.com/lxgw/LxgwNeoZhiSong/releases/download/v${PV}/LXGWHeartSerifCHS.ttf
"
LICENSE="IPAfont"
SLOT="0"
KEYWORDS="~amd64 ~loong ~riscv ~x86"

# Has to fall back to distdir until author offers tarball
S="${DISTDIR}"
FONT_SUFFIX="ttf"
FONT_S="${DISTDIR}"
