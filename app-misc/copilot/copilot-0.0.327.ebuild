# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="The power of GitHub Copilot, now in your terminal"
HOMEPAGE="https://github.com/github/copilot-cli"
SRC_URI="https://registry.npmjs.org/@github/copilot/-/${P}.tgz"
S="${WORKDIR}"/package

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror strip"

RDEPEND="
	net-libs/nodejs
"

src_install() {
	dodoc README.md

	insinto /opt/${PN}
	doins -r ./*
	fperms a+x opt/copilot/index.js

	dodir /opt/${PN}
	dosym -r /opt/${PN}/index.js /opt/bin/copilot
}
