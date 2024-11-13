# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module
GIT_COMMIT=0ca9b8b13fc69121144d85365c16b3e21508ffc3

DESCRIPTION="A tiny command line DNS client with support for UDP, TCP, DoT, DoH, DoQ and ODoH"
HOMEPAGE="https://github.com/natesales/q"

SRC_URI="
	https://github.com/natesales/q/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/peeweep/gentoo-go-deps/releases/download/${P}/${P}-vendor.tar.xz
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

src_compile() {
	local ldflags="\
		-X main.version=${PV} \
		-X main.commit=${GIT_COMMIT} \
		-X main.date=$(date -u +%Y-%m-%dT%H:%M:%SZ) \
		-w -s"
	ego build -o ${P} -trimpath -ldflags "${ldflags}"
}

src_install() {
	newbin ${P} q-dns
}
