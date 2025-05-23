# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg-utils

DESCRIPTION="An SVG icon theme with lots of new icons for GNU/Linux operating systems"
HOMEPAGE="https://github.com/bikass/kora"
MY_PN="${PN%-icon-theme}"
SRC_URI="https://github.com/bikass/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	rm -fv im1.png im2.png korla_aps.jpg LICENSE README.md || die
	find . -name '*.sh' -delete || die
	find . -name '*.cache' -delete || die
	insinto /usr/share/icons
	doins -r .
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
