# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV="${PV}-f57cb59"

DESCRIPTION="Cursor CLI - interact with AI agents directly from your terminal"
HOMEPAGE="https://docs.cursor.com/en/cli"
SRC_URI="
	amd64? ( https://downloads.cursor.com/lab/${MY_PV}/linux/x64/agent-cli-package.tar.gz -> ${P}-x64.tar.gz )
	arm64? ( https://downloads.cursor.com/lab/${MY_PV}/linux/arm64/agent-cli-package.tar.gz -> ${P}-arm64.tar.gz )
"
S="${WORKDIR}"/dist-package

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"
RESTRICT="bindist mirror strip"

RDEPEND="
	net-libs/nodejs
	sys-apps/ripgrep
"

src_install() {
	rm -r -f rg node || die
	sed -i 's|NODE_BIN="\$SCRIPT_DIR/node"|NODE_BIN="node"|' cursor-agent || die
	dodir "/opt/${PN}"
	cp -ar . "${D}/opt/${PN}/" || die
	dosym "../${PN}/${PN}" "/opt/bin/${PN}"
}
