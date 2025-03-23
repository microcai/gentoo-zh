# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module

DESCRIPTION="An easy way to manage all your Geo resources"
HOMEPAGE="https://github.com/MetaCubeX/geo/"
COMMIT_ID="a4db326ccfd7e21276d5d05f4f7e512d14415553"
SRC_URI="
	https://github.com/MetaCubeX/geo/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz
	https://github.com/gentoo-zh/gentoo-deps/releases/download/${P}/${P}-vendor.tar.xz
"
S="${WORKDIR}/geo-${COMMIT_ID}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	ego build -trimpath -ldflags "-w -s" ./cmd/geo
}

src_install() {
	dobin "${PN}"
}
