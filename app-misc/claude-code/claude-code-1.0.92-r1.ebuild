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

	# nodejs defaults to disabling deprecation warnings when running code
	# from any path containing a node_modules directory. Since we're installing
	# outside of the realm of npm, explicitly pass an option to disable
	# deprecation warnings so it behaves the same as it does if installed via
	# npm. It's proprietary; not like Gentoo users can fix the warnings anyway.
	sed -i 's/env node/env -S node --no-deprecation/' cli.js

	dodoc README.md LICENSE.md

	insinto /opt/${PN}
	doins -r ./*
	fperms a+x opt/claude-code/cli.js

	dodir /opt/${PN}
	dosym -r /opt/${PN}/cli.js /opt/bin/claude

	# Create symlink for ripgrep binary since claude-code requires it for custom slash commands.
	# This is a potential BUG.
	if use amd64; then
		dodir /opt/${PN}/vendor/ripgrep/x64-linux
		dosym -r /usr/bin/rg /opt/${PN}/vendor/ripgrep/x64-linux/rg
	elif use arm64; then
		dodir /opt/${PN}/vendor/ripgrep/arm64-linux
		dosym -r /usr/bin/rg /opt/${PN}/vendor/ripgrep/arm64-linux/rg
	fi

	insinto /etc/${PN}
	doins "${FILESDIR}/managed-settings.json"
}
