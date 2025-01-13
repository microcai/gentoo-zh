# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Manage your dotfiles across multiple diverse machines, securely."
HOMEPAGE="https://www.chezmoi.io https://github.com/twpayne/chezmoi"
SRC_URI="https://github.com/twpayne/chezmoi/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://github.com/tsln1998/gentoo-deps/releases/download/${P}/${P}-vendor.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="dev-vcs/git"
RDEPEND+=" !app-admin/chezmoi-bin"
BDEPEND=">=dev-lang/go-1.23.4"

src_compile() {
	ego build
}

src_install() {
	dobin chezmoi

	dodoc README.md

	insinto /usr/share/bash-completion/completions
	newins completions/chezmoi-completion.bash ${PN}

	insinto /usr/share/zsh/vendor-completions
	newins completions/chezmoi.zsh _${PN}
}
