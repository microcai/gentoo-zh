# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module

DESCRIPTION="An offline tool for querying IP geographic information and CDN provider."
HOMEPAGE="https://github.com/zu1k/nali"
EGIT_COMMIT="559ba291a7fabd796f79e0476b8759be9754be63"
SRC_URI="
	https://github.com/zu1k/nali/archive/${EGIT_COMMIT}.tar.gz -> ${P}.gh.tar.gz
	https://github.com/peeweep/gentoo-go-deps/releases/download/${P}/${P}-deps.tar.xz
"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

src_compile() {
	local ldflags="\
		-X \"github.com/zu1k/nali/internal/constant.Version=${PV}\" \
		-w -s"
	ego build -o ${P} -trimpath -ldflags "${ldflags}"
}

src_install() {
	newbin ${P} ${PN}
}
