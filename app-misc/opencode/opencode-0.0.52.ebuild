# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="AI coding agent, built for the terminal"
HOMEPAGE="https://github.com/sst/opencode https://opencode.ai"
SRC_URI="
	https://github.com/sst/opencode/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/douglarek/gentoo-deps/releases/download/${P}/${P}-vendor.tar.xz
"
S="${WORKDIR}"/${P}

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"

src_compile() {
	local ldflags="\
		-X github.com/sst/opencode/internal/version.Version=${PV}"
	ego build -o ${PN} -trimpath -ldflags "${ldflags}"
}

src_install() {
	dobin ${PN}
}
