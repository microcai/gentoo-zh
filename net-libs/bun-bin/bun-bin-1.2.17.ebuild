# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Incredibly fast JavaScript runtime, bundler, test runner, and package manager"
HOMEPAGE="https://bun.sh https://github.com/oven-sh/bun"
SRC_URI="
	amd64? ( https://github.com/oven-sh/bun/releases/download/bun-v${PV}/bun-linux-x64.zip -> ${P}-amd64.zip )
	arm64? ( https://github.com/oven-sh/bun/releases/download/bun-v${PV}/bun-linux-aarch64.zip -> ${P}-arm64.zip )
"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"

BDEPEND="app-arch/unzip"

RESTRICT="strip"

QA_PREBUILT="usr/bin/bun"

src_configure() {
	# Move bun binary from arch-specific directory to workdir root
	mv bun-linux*/bun . || die "Failed to move bun binary"
}

src_install() {
	dobin bun
	dosym bun /usr/bin/bunx
}
