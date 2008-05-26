# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Optional package which provides some icon themes for smplayer."
HOMEPAGE="http://smplayer.sourceforge.net/"
SRC_URI="mirror://sourceforge/smplayer/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=""
RDEPEND="media-video/smplayer"

src_compile()
{
	einfo "do nothing"
}
src_install()
{
	dodir /usr/share/smplayer/themes
	cp -r themes/* ${D}/usr/share/smplayer/themes
}
