# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 autotools

DESCRIPTION="Software for opening links from snaps in desktop"
HOMEPAGE="https://github.com/snapcore/snapd-xdg-open"
EGIT_REPO_URI="https://github.com/snapcore/snapd-xdg-open.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf --prefix=/usr \
		--libexecdir=/usr/lib/"${PN}"
}

src_install() {
	default
	exeinto /usr/lib/"${PN}"
	doexe src/xdg-open
}
