# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="AI coding agent, built for the terminal"
HOMEPAGE="https://github.com/sst/opencode"
SRC_URI="
	amd64? ( https://github.com/sst/opencode/releases/download/v${PV}/opencode-linux-x64.zip -> ${P}-amd64.zip )
	arm64? ( https://github.com/sst/opencode/releases/download/v${PV}/opencode-linux-arm64.zip -> ${P}-arm64.zip )
"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"

BDEPEND="app-arch/unzip"

RESTRICT="strip"

src_install() {
	dobin opencode
}
