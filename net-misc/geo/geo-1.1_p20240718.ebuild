# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module

DESCRIPTION="An easy way to manage all your Geo resources"
HOMEPAGE="https://github.com/MetaCubeX/geo/"
EGIT_COMMIT="a4db326ccfd7e21276d5d05f4f7e512d14415553"
SRC_URI="
	https://github.com/MetaCubeX/geo/archive/${EGIT_COMMIT}.tar.gz -> ${P}.gh.tar.gz
	https://github.com/peeweep/gentoo-go-deps/releases/download/${P}/${P}-deps.tar.xz
"

S="${WORKDIR}/geo-${EGIT_COMMIT}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	ego build -trimpath -ldflags "-w -s" ./cmd/geo
}

src_install() {
	dobin "${PN}"
}
