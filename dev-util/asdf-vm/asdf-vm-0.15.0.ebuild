# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1

DESCRIPTION="Manage all your runtime versions with one tool"
HOMEPAGE="https://github.com/asdf-vm/asdf"
SRC_URI="https://github.com/asdf-vm/asdf/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/asdf-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	net-misc/curl
	dev-vcs/git
"

DOCS=( CHANGELOG.md README.md )

src_install() {
	dodoc README.md

	insinto /opt/${PN}
	doins -r bin
	doins -r lib
	doins asdf.{elv,fish,nu,ps1,sh}
	doins defaults
	doins help.txt
	doins version.txt

	fperms +x /opt/${PN}/bin/asdf
	fperms +x /opt/${PN}/bin/private/asdf-exec
	fperms +x /opt/${PN}/asdf.{elv,fish,nu,ps1,sh}

	dobashcomp completions/asdf.bash

	insinto /usr/share/zsh/site-functions
	doins completions/_asdf

	insinto /usr/share/fish/vendor_completions.d
	doins completions/asdf.fish
}
