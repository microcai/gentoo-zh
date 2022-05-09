# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

DESCRIPTION="Sarasa Mono SC font patched with Nerd fonts"
HOMEPAGE="https://github.com/laishulu/Sarasa-Mono-SC-Nerd"

SRC_URI="https://github.com/laishulu/Sarasa-Mono-SC-Nerd/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

RESTRICT="mirror"

S="${WORKDIR}/Sarasa-Mono-SC-Nerd-${PV}"
FONT_SUFFIX="ttf"
