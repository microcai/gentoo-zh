# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Gemini CLI - a command-line AI workflow tool by Google"
HOMEPAGE="https://github.com/google-gemini/gemini-cli"
SRC_URI="https://github.com/google-gemini/gemini-cli/releases/download/v${PV}/gemini.js -> ${P}.js"
S="${WORKDIR}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="strip"

RDEPEND="
	>=net-libs/nodejs-20
"

src_unpack() {
	# npm installs the tarball directly
	:
}

src_compile() {
	# Skip, nothing to compile here.
	:
}

src_install() {
	newbin "${DISTDIR}/${P}.js" gemini
}
