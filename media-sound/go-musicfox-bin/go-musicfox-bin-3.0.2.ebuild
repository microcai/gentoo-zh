# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Command-line Netease Cloud Music written in Go(bin version)"
HOMEPAGE="https://github.com/anhoder"
SRC_URI="https://github.com/anhoder/go-musicfox/releases/download/v${PV}/go-musicfox_${PV}_linux_amd64.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="media-libs/flac media-libs/alsa-lib"
RDEPEND="${DEPEND}"
BDEPEND="app-arch/unzip"

QA_PREBUILT="/usr/bin/musicfox"

S=${WORKDIR}

src_install() {
	cd go-musicfox* || die
	dobin musicfox
}
