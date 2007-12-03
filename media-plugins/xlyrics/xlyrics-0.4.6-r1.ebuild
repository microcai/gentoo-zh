# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="lyrics display plugin for xmms/bmp/audacious/amarok"
HOMEPAGE="http://myget.sourceforge.net/xlyrics/"
SRC_URI="http://myget.sourceforge.net/xlyrics/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.4.0
		>=dev-libs/glib-2.4.0
		>=media-sound/audacious-1.4.2"

RDEPEND="${DEPEND}"

src_unpack(){
	unpack "${A}"
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-audacious-1.4.2.patch
	./autogen.sh
}

src_install(){
	emake install DESTDIR="${D}" || die "install faled"
}

