# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module

DESCRIPTION="A TLS server scanner for Reality"
HOMEPAGE="https://github.com/XTLS/RealiTLScanner"

SRC_URI="
	https://github.com/XTLS/RealiTLScanner/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/peeweep/gentoo-go-deps/releases/download/${P}/${P}-vendor.tar.xz
"

S="${WORKDIR}/RealiTLScanner-${PV}"
LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

src_compile() {
	local ldflags="\
		-w -s"
	ego build -o ${P} -trimpath -ldflags "${ldflags}"
}

src_install() {
	newbin ${P} ${PN}
}
