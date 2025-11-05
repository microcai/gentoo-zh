# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module
COMMIT_ID="3f3ae8d2a8d58aed559f1b6be27e76f1e669d1d9"

DESCRIPTION="A tiny command line DNS client with support for UDP, TCP, DoT, DoH, DoQ and ODoH"
HOMEPAGE="https://github.com/natesales/q"

SRC_URI="
	https://github.com/natesales/q/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/gentoo-zh-drafts/q/releases/download/v${PV}/${P}-vendor.tar.xz
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
BDEPEND=">=dev-lang/go-1.25"

src_compile() {
	local ldflags="\
		-X main.version=${PV} \
		-X main.commit=${COMMIT_ID} \
		-X main.date=$(date -u +%Y-%m-%dT%H:%M:%SZ)"
	ego build -o ${P} -trimpath -ldflags "${ldflags}"
}

src_install() {
	newbin ${P} q-dns
}
