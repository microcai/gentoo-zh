# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Unofficial CLI for speed.cloudflare.com "
HOMEPAGE="https://github.com/code-inflation/cfspeedtest"
URL_PREFIX="https://github.com/code-inflation/cfspeedtest/releases/download"
SRC_URI="${URL_PREFIX}/v${PV}/cfspeedtest-x86_64-unknown-linux-gnu.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}"
LICENSE="MIT"

SLOT="0"
KEYWORDS="-* ~amd64"

RESTRICT="strip"

RDEPEND="sys-fs/fuse:0"

QA_PREBUILT="/usr/bin/cfspeedtest"

src_install() {
	dobin cfspeedtest
}
