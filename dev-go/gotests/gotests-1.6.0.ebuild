# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Automatically generate Go test boilerplate from your source code"
HOMEPAGE="https://github.com/cweill/gotests"
SRC_URI="https://github.com/cweill/gotests/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/douglarek/gentoo-deps/releases/download/${P}/${P}-vendor.tar.xz"
S="${WORKDIR}/${P}"

LICENSE="BSD MIT"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"

DEPEND="dev-lang/go"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}"/${P}-fix-go-mod.patch )

src_compile() {
	ego build -o "bin/${PN}" "./${PN}"
}

src_test() {
	ego test ./...
}

src_install() {
	dobin "bin/${PN}"
}
