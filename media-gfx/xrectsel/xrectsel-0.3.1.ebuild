# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="print the geometry of a rectangular screen region"
HOMEPAGE="https://github.com/lolilolicon/xrectsel"
SRC_URI="https://github.com/lolilolicon/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RESTRICT="mirror"

DEPEND=""
RDEPEND="${DEPEND}
	x11-libs/libX11"

src_prepare() {
	eautoreconf
}
