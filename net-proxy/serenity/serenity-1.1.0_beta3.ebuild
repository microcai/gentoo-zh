# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

_PV="${PV/_/-}"
_PV="${_PV/alpha/alpha.}"
_PV="${_PV/beta/beta.}"

DESCRIPTION="The configuration generator for sing-box"
HOMEPAGE="https://serenity.sagernet.org/ https://github.com/SagerNet/serenity"
SRC_URI="
	https://github.com/SagerNet/serenity/archive/refs/tags/v${_PV}.tar.gz -> ${P}.tar.gz
	https://github.com/peeweep/gentoo-go-deps/releases/download/${P}/${P}-vendor.tar.xz
"

S="${WORKDIR}/${PN}-${_PV}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

src_install(){
	dobin serenity
}
