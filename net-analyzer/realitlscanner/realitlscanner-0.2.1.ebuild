# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module

DESCRIPTION="A TLS server scanner for Reality"
HOMEPAGE="https://github.com/XTLS/RealiTLScanner"

SRC_URI="
	https://github.com/XTLS/RealiTLScanner/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/gentoo-zh-drafts/RealiTLScanner/releases/download/v${PV}/RealiTLScanner-${PV}-vendor.tar.xz
		-> ${P}-vendor.golang-dist-mirror-action.tar.xz
"

S="${WORKDIR}/RealiTLScanner-${PV}"
LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

src_compile() {
	ego build -o ${P}
}

src_install() {
	newbin ${P} ${PN}
}
