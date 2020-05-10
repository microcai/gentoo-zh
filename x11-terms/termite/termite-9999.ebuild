# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 eutils

DESCRIPTION="A keyboard-centric VTE-based terminal"
EGIT_REPO_URI="https://github.com/thestinger/termite"
HOMEPAGE="https://github.com/thestinger/termite"
SLOT="0"

LICENSE="MIT"

KEYWORDS="~amd64 ~x86"

IUSE="nocsd"

RDEPEND="
	x11-terms/vte-ng
"

src_prepare() {
	default
	sed -i /-s /d Makefile

	if use nocsd; then
		epatch "${FILESDIR}/${PN}-nocsd.patch"
	fi
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install
}

