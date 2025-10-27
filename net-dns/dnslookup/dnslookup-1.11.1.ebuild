# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module

DESCRIPTION="Simple command line utility to make DNS lookups to the specified server "
HOMEPAGE="https://github.com/ameshkov/dnslookup"

SRC_URI="
	https://github.com/ameshkov/dnslookup/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/gentoo-zh-drafts/dnslookup/releases/download/v${PV}/${P}-vendor.tar.xz
		-> ${P}-vendor.golang-dist-mirror-action.tar.xz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

src_compile() {
	ego build -o ${P} -ldflags "-X main.VersionString=${PV}"
}

src_install() {
	newbin ${P} dnslookup
}
