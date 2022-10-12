# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Command-line Netease Cloud Music written in Go"
HOMEPAGE="https://github.com/anhoder"
SRC_URI="https://github.com/anhoder/go-musicfox/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="media-libs/flac media-libs/alsa-lib"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND} sys-devel/gcc[objc]"

src_compile() {
	ego build -o musicfox cmd/musicfox.go
}

src_install() {
	dobin musicfox
}
