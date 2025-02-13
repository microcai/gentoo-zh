# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="Cherry Studio is a desktop client that supports for multiple LLM providers."
HOMEPAGE="https://github.com/CherryHQ/cherry-studio"
SRC_URI="https://github.com/CherryHQ/cherry-studio/releases/download/v${PV}/Cherry-Studio-${PV}-x86_64.AppImage -> ${P}.AppImage"

S="${WORKDIR}"
LICENSE="Cherry-Studio"

SLOT="0"
KEYWORDS="~amd64"

RESTRICT="strip"

src_unpack() {
	cp "${DISTDIR}/${P}.AppImage" cherry-studio || die
}

src_install() {
	dobin cherry-studio
	domenu "${FILESDIR}/cherry-studio.desktop"
	doicon -s scalable "${FILESDIR}/cherry-studio.svg"
}
