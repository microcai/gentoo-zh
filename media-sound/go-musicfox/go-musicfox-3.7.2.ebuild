# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Command-line Netease Cloud Music written in Go"
HOMEPAGE="https://github.com/anhoder"
SRC_URI="https://github.com/anhoder/go-musicfox/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="clang"
RESTRICT="mirror"

DEPEND="
	media-libs/flac
	media-libs/alsa-lib
"
RDEPEND="${DEPEND}"
BDEPEND="
	${DEPEND}
	clang? ( sys-devel/clang )
	!clang? ( sys-devel/gcc[objc] )
"

src_compile() {
	if use clang ; then
		ego env -w "CC=clang"
		ego env -w "CXX=clang++"
	fi
	ego build -o musicfox -ldflags "-s -w -X go-musicfox/pkg/constants.AppVersion=v${PV}" cmd/musicfox.go
}

src_install() {
	dobin musicfox
}
