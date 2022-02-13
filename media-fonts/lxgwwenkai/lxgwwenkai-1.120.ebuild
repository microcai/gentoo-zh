# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font
WENKAI="LXGWWenKai"
WENKAI_MONO="LXGWWenKaiMono"
LATIN_FONTS_DIR="LxgwWenKai-${PV}/MonoLatin"

WENKAI_CJK=(
	"${WENKAI}-Bold-${PV}.ttf"
	"${WENKAI}-Light-${PV}.ttf"
	"${WENKAI}-Regular-${PV}.ttf"
	"${WENKAI_MONO}-Bold-${PV}.ttf"
	"${WENKAI_MONO}-Light-${PV}.ttf"
	"${WENKAI_MONO}-Regular-${PV}.ttf"
)

DESCRIPTION="An open-source Chinese font derived from Fontworks' Klee One."
HOMEPAGE="https://lxgw.github.io/2021/01/28/Klee-Simpchin"
SRC_URI="https://github.com/lxgw/LxgwWenKai/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://github.com/lxgw/LxgwWenKai/releases/download/v${PV}/${WENKAI}-Bold.ttf -> ${WENKAI}-Bold-${PV}.ttf"
SRC_URI+=" https://github.com/lxgw/LxgwWenKai/releases/download/v${PV}/${WENKAI}-Light.ttf -> ${WENKAI}-Light-${PV}.ttf"
SRC_URI+=" https://github.com/lxgw/LxgwWenKai/releases/download/v${PV}/${WENKAI}-Regular.ttf -> ${WENKAI}-Regular-${PV}.ttf"
SRC_URI+=" https://github.com/lxgw/LxgwWenKai/releases/download/v${PV}/${WENKAI_MONO}-Bold.ttf -> ${WENKAI_MONO}-Bold-${PV}.ttf"
SRC_URI+=" https://github.com/lxgw/LxgwWenKai/releases/download/v${PV}/${WENKAI_MONO}-Light.ttf -> ${WENKAI_MONO}-Light-${PV}.ttf"
SRC_URI+=" https://github.com/lxgw/LxgwWenKai/releases/download/v${PV}/${WENKAI_MONO}-Regular.ttf -> ${WENKAI_MONO}-Regular-${PV}.ttf"

S="${WORKDIR}"
LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=""
DEPEND=""
BDEPEND=""
FONT_SUFFIX="ttf"
FONT_S=(
	"${S}/${LATIN_FONTS_DIR}"
	"${S}"
)

src_unpack() {
	default

	# CJK fonts are not included in the tarball
	# need to copy them to the ${S} dir for installation
	for font in "${WENKAI_CJK[@]}"; do
	  cp "${DISTDIR}/${font}" "${S}"/ || die
	done
}
