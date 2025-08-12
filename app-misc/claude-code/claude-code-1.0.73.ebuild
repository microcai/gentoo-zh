# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Claude Code - an agentic coding tool by Anthropic"
HOMEPAGE="https://www.anthropic.com/claude-code"
SRC_URI="
	https://registry.npmjs.org/@anthropic-ai/claude-code/-/${P}.tgz
"
S="${WORKDIR}"/package

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"
RESTRICT="bindist mirror strip"

RDEPEND="
	!dev-util/claude-code
	net-libs/nodejs
	sys-apps/ripgrep
"

src_install() {
	rm -r -f sdk* vendor package.json || die
	dodir "/opt/${PN}"
	cp -ar . "${D}/opt/${PN}/" || die
	dosym "../${PN}/cli.js" "/opt/bin/claude"
	# disable auto-updater
	insinto /etc/claude-code
	doins "${FILESDIR}/managed-settings.json"
}
