# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

_PN="Numix"

DESCRIPTION="A modern flat theme that supports Gnome, Unity, XFCE and Openbox."
HOMEPAGE="https://numixproject.org"

SRC_URI=""
EGIT_REPO_URI="https://github.com/shimmerproject/${_PN}.git"
KEYWORDS=""
LICENSE="GPL-3.0+"
SLOT="0"

DEPEND="x11-themes/gtk-engines-murrine"
RDEPEND="${DEPEND}"

src_install() {
	insinto /usr/share/themes/Numix
	doins -r .
	dodoc README.md
}
