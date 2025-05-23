# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module

DESCRIPTION="An easy way to manage all your Geo resources"
HOMEPAGE="https://github.com/MetaCubeX/geo/"
SRC_URI="
	https://github.com/MetaCubeX/geo/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/peeweep/gentoo-go-deps/releases/download/${P}/${P}-vendor.tar.xz
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	ego build -trimpath -ldflags "-w -s" ./cmd/geo
}

src_install() {
	dobin "${PN}"
}
