# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="A cross-platform version manager, extendable via plugins"
HOMEPAGE="https://vfox.lhan.me https://github.com/version-fox/vfox"
SRC_URI="https://github.com/version-fox/vfox/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://github.com/tsln1998/gentoo-deps/releases/download/${P}/${P}-vendor.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="app-shells/bash"
RDEPEND+=" !dev-util/vfox-bin"
BDEPEND=">=dev-lang/go-1.21.7"

src_compile() {
	local ldflags="-w -s"
	ego build -o ${P} -trimpath -ldflags "${ldflags}"
}

src_install() {
	newbin ${P} ${PN}

	dodoc README.md

	insinto /usr/share/bash-completion/completions
	newins completions/bash_autocomplete ${PN}

	insinto /usr/share/zsh/site-functions
	newins completions/zsh_autocomplete _${PN}
}
