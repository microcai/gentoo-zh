# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

DESCRIPTION="Sarasa Mono SC font patched with Nerd fonts"
HOMEPAGE="https://github.com/laishulu/Sarasa-Term-SC-Nerd"

SRC_URI="https://github.com/laishulu/Sarasa-Term-SC-Nerd/releases/download/v${PV}/${PN}.ttf.tar.gz -> ${P}.tar.gz"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
DEPEND=""
RDEPEND=""

RESTRICT="mirror"

S="${WORKDIR}"
FONT_SUFFIX="ttf"
