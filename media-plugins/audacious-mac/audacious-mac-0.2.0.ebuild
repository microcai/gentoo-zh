# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Monkey's Audio Codec plugin for audacious"
HOMEPAGE="http://www.netswarm.net/"
SRC_URI="http://www.netswarm.net/misc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	media-sound/audacious
	media-sound/mac"
RDEPEND="media-sound/audacious"

RESTRICT="primaryuri"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
