# Copyright 2021-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="tun2socks - powered by gVisor TCP/IP stack"
HOMEPAGE="https://github.com/xjasonlyu/tun2socks"
SRC_URI="
	https://github.com/xjasonlyu/tun2socks/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/gentoo-zh-drafts/tun2socks/releases/download/v${PV}/${P}-vendor.tar.xz
"

COMMIT_ID="4127937e"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND=">=dev-lang/go-1.25.0"

src_compile() {
	ego build -o tun2socks -ldflags "
		-X 'github.com/xjasonlyu/tun2socks/v2/internal/version.Version=${PV}'
		-X 'github.com/xjasonlyu/tun2socks/v2/internal/version.GitCommit=${COMMIT_ID}'
	"
}

src_install() {
	dobin tun2socks
}
