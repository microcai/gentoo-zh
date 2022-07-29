# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="lazygit, a simple terminal UI for git commands"
HOMEPAGE="https://github.com/jesseduffield/lazygit"
SRC_URI="amd64? ( https://github.com/jesseduffield/lazygit/releases/download/v${PV}/${PN%-bin}_${PV}_Linux_x86_64.tar.gz )
	x86? ( https://github.com/jesseduffield/lazygit/releases/download/v${PV}/${PN%-bin}_${PV}_Linux_32-bit.tar.gz )
	arm64? ( https://github.com/jesseduffield/lazygit/releases/download/v${PV}/${PN%-bin}_${PV}_Linux_arm64.tar.gz )
	arm? ( https://github.com/jesseduffield/lazygit/releases/download/v${PV}/${PN%-bin}_${PV}_Linux_armv6.tar.gz )
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86 "

RESTRICT="strip"

CONFLICTS="!dev-vcs/lazygit"
RDEPEND="
	${CONFLICTS}
	dev-vcs/git
"

DOCS=( README.md )

S="${WORKDIR}"

src_install(){
	dobin ${PN%-bin}

	default
}
