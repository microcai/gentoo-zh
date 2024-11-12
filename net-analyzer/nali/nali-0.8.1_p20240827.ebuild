# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module

DESCRIPTION="An offline tool for querying IP geographic information and CDN provider."
HOMEPAGE="https://github.com/zu1k/nali"
EGIT_COMMIT="2e758d311739bc402ba63bda7ba081d565c0cf0f"
SRC_URI="
	https://github.com/zu1k/nali/archive/${EGIT_COMMIT}.tar.gz -> ${P}.gh.tar.gz
	https://github.com/peeweep/gentoo-go-deps/releases/download/${P}/${P}-vendor.tar.xz
"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

src_compile() {
	local ldflags="\
		-X \"github.com/zu1k/nali/internal/constant.Version=${PV}\" \
		-w -s"
	ego build -trimpath -ldflags "${ldflags}"
}

src_install() {
	dobin ${PN}
}
