# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Manage all your runtime versions with one tool"
HOMEPAGE="https://github.com/asdf-vm/asdf"
SRC_URI="
	https://github.com/asdf-vm/asdf/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/gentoo-zh-drafts/asdf/releases/download/v${PV}/asdf-${PV}-vendor.tar.xz
		-> ${P}-vendor.golang-dist-mirror-action.tar.xz
"
S="${WORKDIR}/asdf-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	net-misc/curl
	dev-vcs/git
"
BDEPEND=">=dev-lang/go-1.23.4"

DOCS=( CHANGELOG.md README.md )

src_compile() {
	local ldflags="-X 'main.Version=${PV}'"
	ego build -o ${P} -ldflags "${ldflags}" ./cmd/asdf
}

src_install() {
	dodoc README.md

	newbin ${P} asdf
}
