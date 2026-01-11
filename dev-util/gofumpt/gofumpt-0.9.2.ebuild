# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="A stricter gofmt"
HOMEPAGE="https://github.com/mvdan/gofumpt"
SRC_URI="
	https://github.com/mvdan/gofumpt/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/gentoo-zh-drafts/gofumpt/releases/download/v${PV}/${P}-vendor.tar.xz
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
BDEPEND=">=dev-lang/go-1.24.0"
RESTRICT="test"

src_compile() {
	local ldflags="-X 'mvdan.cc/gofumpt/internal/version.version=${PV}'"
	ego build -o gofumpt -ldflags "${ldflags}"
}

src_install() {
	dobin gofumpt
	einstalldocs
}
