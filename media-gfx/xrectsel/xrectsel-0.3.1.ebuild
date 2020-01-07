# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit autotools

DESCRIPTION="print the geometry of a rectangular screen region"
HOMEPAGE="https://github.com/lolilolicon/xrectsel"
SRC_URI="https://github.com/lolilolicon/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="mirror"

DEPEND=""
RDEPEND="${DEPEND}
	x11-libs/libX11"

src_prepare() {
	eautoreconf
}
