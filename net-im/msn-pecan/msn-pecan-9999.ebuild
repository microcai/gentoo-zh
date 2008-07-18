# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit git multilib

DESCRIPTION="Alternative MSN protocol plug-in for pidgin"
HOMEPAGE="http://code.google.com/p/msn-pecan/"
EGIT_REPO_URI="git://github.com/felipec/msn-pecan.git"

LICENSE="GPL-2"
KEYWORDS=""
IUSE=""
SLOT="0"

RDEPEND="net-im/pidgin"

DEPEND="${DEPEND}
	dev-util/pkgconfig"

src_install() {
	exeinto /usr/$(get_libdir)/purple-2
	doexe libmsn-pecan.so
	dodoc README TODO
}

