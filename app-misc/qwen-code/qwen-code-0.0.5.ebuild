# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Qwen Code is a powerful command-line AI workflow tool adapted from Gemini CLI"
HOMEPAGE="https://github.com/QwenLM/qwen-code"
SRC_URI="https://github.com/QwenLM/qwen-code/releases/download/v${PV}/gemini.js -> ${P}.js"
S="${WORKDIR}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"

RDEPEND="
	net-libs/nodejs
"

src_install() {
	newbin "${DISTDIR}/${P}.js" qwen
}
