# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

MY_PN="iansui"

DESCRIPTION="An open-source Chinese font derived from Klee One (Fontworks)."
HOMEPAGE="https://github.com/ButTaiwan/iansui"
SRC_URI="https://github.com/ButTaiwan/iansui/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${MY_PN}-${PV}"
LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=""
DEPEND=""
BDEPEND=""
FONT_SUFFIX="ttf"
FONT_S="${S}"

src_unpack() {
	default

	# remove README.md to prevent it from being installed as doc
	rm "${S}/README.md" || die
}
