# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module
GIT_COMMIT=7ddddd3c97994c59fe282f5c9dad346be34b328b

DESCRIPTION="A tiny command line DNS client with support for UDP, TCP, DoT, DoH, DoQ and ODoH"
HOMEPAGE="https://github.com/natesales/q"

SRC_URI="
	https://github.com/natesales/q/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/gentoo-zh/gentoo-deps/releases/download/${P}/${P}-vendor.tar.xz
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

src_compile() {
	local ldflags="\
		-X main.version=${PV} \
		-X main.commit=${GIT_COMMIT} \
		-X main.date=$(date -u +%Y-%m-%dT%H:%M:%SZ)"
	ego build -o ${P} -trimpath -ldflags "${ldflags}"
}

src_install() {
	newbin ${P} q-dns
}
