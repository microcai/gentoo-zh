# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

MY_PN="lxgw-wenkai"
DESCRIPTION="An open-source Chinese font derived from Fontworks' Klee One."
HOMEPAGE="https://lxgw.github.io/2021/01/28/Klee-Simpchin"

SRC_URI="https://github.com/lxgw/LxgwWenKai/releases/download/v${PV}/${MY_PN}-v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"

S="${WORKDIR}/${PN}-${PV}"
LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=""
DEPEND=""
BDEPEND=""
FONT_SUFFIX="ttf"

src_unpack() {
	default

	# rename the unpacked dir to ${P}
	mv "${WORKDIR}/${MY_PN}-v${PV}" "${WORKDIR}/${P}" || die
}


