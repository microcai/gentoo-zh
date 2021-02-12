# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games

DESCRIPTION="Othello is a classic strategy game, also known as Reversi"
HOMEPAGE="http://othello-game.sourceforge.net"
SRC_URI="mirror://sourceforge/othello-game/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RESTRICT="mirror"

DEPEND="dev-libs/boost
	>=x11-libs/wxGTK-2.6"
RDEPEND="${DEPEND}"

pkg_setup() {

	if has_version =dev-libs/boost-1.33* && ! built_with_use dev-libs/boost threads; then
		einfo "Please re-emerge dev-libs/boost with the threads USE flag set"
		die "boost needs the threads flag set"
	fi

}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
}
