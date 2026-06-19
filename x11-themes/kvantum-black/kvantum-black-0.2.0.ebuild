# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Black Catppuccin themes for Kvantum"
HOMEPAGE="https://github.com/vitaly-zdanevich/kvantum-black"
SRC_URI="https://github.com/vitaly-zdanevich/kvantum-black/releases/download/v${PV}/${P}.tar.gz"
S="${WORKDIR}/kvantum-black-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="x11-themes/kvantum"

src_install() {
	insinto /usr/share/Kvantum
	doins -r themes/*

	dodoc README.md
}
