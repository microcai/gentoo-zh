# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module
COMMIT_ID="628e9a3746161e2f47df6b6dfcc3784122f9e499"

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
