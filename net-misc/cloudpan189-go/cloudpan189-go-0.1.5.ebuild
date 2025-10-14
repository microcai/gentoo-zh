# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="189 cloudpan cli"
HOMEPAGE="https://github.com/MaurUppi/cloudpan189-go"

SRC_URI="https://github.com/MaurUppi/cloudpan189-go/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/gentoo-zh/gentoo-deps/releases/download/${P}/${P}-vendor.tar.xz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	ego build -ldflags="-checklinkname=0" -o bin/${PN}
}

src_install() {
	dobin bin/${PN}
}
