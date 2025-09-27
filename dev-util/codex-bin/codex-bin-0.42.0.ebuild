# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="codex-x86_64-unknown-linux-musl"

DESCRIPTION="Codex - OpenAI's code generation and completion tool"
HOMEPAGE="https://github.com/openai/codex"
SRC_URI="https://github.com/openai/codex/releases/download/rust-v${PV}/${MY_PN}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="bindist mirror strip"

QA_PREBUILT="usr/bin/codex"

src_install() {
	newbin "${MY_PN}" codex
}
