# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV="${PV/_pre/-preview}"
MY_PV="${MY_PV/preview[0-9]*/preview.${MY_PV##*preview}}"

DESCRIPTION="Gemini CLI - a command-line AI workflow tool by Google"
HOMEPAGE="https://github.com/google-gemini/gemini-cli"
SRC_URI="https://github.com/google-gemini/gemini-cli/releases/download/v${MY_PV}/gemini.js -> ${P}.js"
S="${WORKDIR}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"

RDEPEND="
	net-libs/nodejs
"

src_install() {
	# nodejs defaults to disabling deprecation warnings when running code
	# from any path containing a node_modules directory. Since we're installing
	# outside of the realm of npm, explicitly pass an option to disable
	# deprecation warnings so it behaves the same as it does if installed via
	# npm. It's proprietary; not like Gentoo users can fix the warnings anyway.
	sed -i 's/env node/env -S node --no-deprecation/' "${DISTDIR}/${P}.js" || die

	newbin "${DISTDIR}/${P}.js" gemini
}
