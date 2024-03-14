# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

DESCRIPTION="A Chinese sans-serif font derived from IPAex Gothic."
HOMEPAGE="https://github.com/lxgw/LxgwNeoXiHei"
SRC_URI="https://github.com/lxgw/LxgwNeoXiHei/releases/download/v${PV}/LXGWNeoXiHei.ttf"

LICENSE="IPAfont"
S="${DISTDIR}"
SLOT="0"
KEYWORDS="~amd64"

# Has to fall back to distdir until author offers tarball
FONT_SUFFIX="ttf"
FONT_S="${DISTDIR}"
