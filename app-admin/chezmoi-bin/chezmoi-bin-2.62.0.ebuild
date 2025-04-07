# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

DESCRIPTION="Manage your dotfiles across multiple diverse machines, securely."
HOMEPAGE="https://www.chezmoi.io https://github.com/twpayne/chezmoi"

SRC_URI="
	amd64? ( https://github.com/twpayne/chezmoi/releases/download/v${PV}/chezmoi_${PV}_linux_amd64.deb )
	x86? ( https://github.com/twpayne/chezmoi/releases/download/v${PV}/chezmoi_${PV}_linux_i386.deb )
	arm64? ( https://github.com/twpayne/chezmoi/releases/download/v${PV}/chezmoi_${PV}_linux_arm64.deb )
	arm? ( https://github.com/twpayne/chezmoi/releases/download/v${PV}/chezmoi_${PV}_linux_armel.deb )
"

S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="dev-vcs/git"
RDEPEND+=" !app-admin/chezmoi"

src_install() {
	default

	dobin usr/bin/chezmoi

	insinto /usr/share/bash-completion/completions
	doins usr/share/bash-completion/completions/chezmoi

	insinto /usr/share/zsh/vendor-completions
	doins usr/share/zsh/vendor-completions/_chezmoi
}
