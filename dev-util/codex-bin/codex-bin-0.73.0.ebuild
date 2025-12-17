# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Codex - OpenAI's code generation and completion tool"
HOMEPAGE="https://github.com/openai/codex"
SRC_URI="
	amd64? (
		https://github.com/openai/codex/releases/download/rust-v${PV}/codex-x86_64-unknown-linux-musl.tar.gz
			-> ${P}-amd64.tar.gz
	)
	arm64? (
		https://github.com/openai/codex/releases/download/rust-v${PV}/codex-aarch64-unknown-linux-musl.tar.gz
			-> ${P}-arm64.tar.gz
	)
"
S="${WORKDIR}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RESTRICT="bindist mirror strip"

QA_PREBUILT="usr/bin/codex"

src_install() {
	if use amd64; then
		newbin codex-x86_64-unknown-linux-musl codex
	elif use arm64; then
		newbin codex-aarch64-unknown-linux-musl codex
	fi
}
