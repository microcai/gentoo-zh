# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1

DESCRIPTION="Pacstrap - install packages to the specified new root directorye"
HOMEPAGE="https://github.com/archlinux/arch-install-scripts https://man.archlinux.org/man/pacstrap.8"
SRC_URI="https://github.com/archlinux/arch-install-scripts/archive/refs/tags/v${PV}.tar.gz -> arch-install-scripts-v${PV}.tar.gz"

S="${WORKDIR}/arch-install-scripts-${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="
	app-alternatives/awk
	app-text/asciidoc
"
DEPEND="sys-apps/pacman"

src_test() {
	emake MANS="doc/pacstrap.8" BINPROGS="pacstrap" check
}

src_compile() {
	emake MANS="doc/pacstrap.8" BINPROGS="pacstrap"
}

src_install() {
	dobin pacstrap
	doman doc/pacstrap.8
	newbashcomp completion/pacstrap.bash pacstrap
}
