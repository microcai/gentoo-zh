# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

_MY_PN="Yacd-meta"

DESCRIPTION="Yet Another Clash Dashboard"
HOMEPAGE="https://github.com/MetaCubeX/Yacd-meta"
SRC_URI="
	https://github.com/MetaCubeX/Yacd-meta/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/st0nie/gentoo-go-deps/releases/download/${P}/${P}-node_modules.tar.xz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="net-libs/nodejs[npm]"
S="${WORKDIR}/${_MY_PN}-${PV}"

src_unpack() {
	default
	mv node_modules "${_MY_PN}-${PV}" || die
}

src_compile() {
	npm run build || die
}

src_install() {
	insinto /usr/share/"${PN}"
	doins -r public/*
}
