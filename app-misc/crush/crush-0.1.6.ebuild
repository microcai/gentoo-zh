# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="The glamourous AI coding agent for your favourite terminal 💘"
HOMEPAGE="https://github.com/charmbracelet/crush"
SRC_URI="
	https://github.com/charmbracelet/crush/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/douglarek/gentoo-deps/releases/download/${P}/${P}-vendor.tar.xz
"
S="${WORKDIR}"/${P}

# https://fsl.software/FSL-1.1-MIT.template.md
LICENSE="FSL-1.1-MIT"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"

src_compile() {
	local ldflags="\
		-X github.com/charmbracelet/crush/internal/version.Version=${PV}"
	ego build -o ${PN} -trimpath -ldflags "${ldflags}"
}

src_install() {
	dobin ${PN}
}
