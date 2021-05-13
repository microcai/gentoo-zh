# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

WX_GTK_VER="3.0-gtk3"
inherit wxwidgets

DESCRIPTION="Othello is a classic strategy game, also known as Reversi"
HOMEPAGE="http://othello-game.sourceforge.net"
SRC_URI="https://sourceforge.net/code-snapshots/git/o/ot/othello-game/code.git/othello-game-code-580b639ffe72dd40ab01bcfda5668d83e521b97d.zip -> ${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-libs/boost[threads]
	x11-libs/wxGTK:${WX_GTK_VER}"
RDEPEND="${DEPEND}"

S="${WORKDIR%/}/othello-game-code-580b639ffe72dd40ab01bcfda5668d83e521b97d/othello/"

pkg_setup() {
	setup-wxwidgets
}

src_configure() {
	./autogen.sh || die
	# only python2 supported but boost not
	econf "--disable-python"
}
