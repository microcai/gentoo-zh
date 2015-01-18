# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Numix Circle icon theme"
HOMEPAGE="https://numixproject.org"

SRC_URI="https://github.com/numixproject/${PN}/archive/master.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3.0+"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="x11-themes/numix-icon-theme"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack "${A}"
	mv "${PN}-master" "${P}"
}

src_install() {
	insinto /usr/share/icons
	doins -r Numix-Circle Numix-Circle-Light
	dodoc readme.md
}
