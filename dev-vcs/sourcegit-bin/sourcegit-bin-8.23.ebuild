# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker xdg

DESCRIPTION="Opensource Git GUI client."
HOMEPAGE="https://github.com/sourcegit-scm/sourcegit"
SRC_URI="https://github.com/sourcegit-scm/sourcegit/releases/download/v${PV}/sourcegit_${PV}-1_amd64.deb"

S="${WORKDIR}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-vcs/git
"

RDEPEND="${DEPEND}"
src_install(){
	dobin "${S}"/opt/sourcegit/sourcegit
	insinto /usr/lib/sourcegit
	domenu usr/share/applications/sourcegit.desktop
	doicon -s 256 usr/share/icons/${PN/-bin}.png
}
