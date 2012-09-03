# Copyright 2008-2012 Funtoo Technologies
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
MY_USER="herenvarno"
DESCRIPTION="A free music player"
HOMEPAGE="http://www.linnya.org"
SRC_URI="https://github.com/${MY_USER}/${PN}/tarball/${PV} -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
		media-libs/gstreamer
		x11-libs/gtk+
		dev-db/sqlite
		net-misc/curl"

src_unpack(){
	unpack ${A}
	mv *-${PN}-* "${S}"
}

src_configure(){
	./autogen
	./configure --prefix=/usr
}

src_install(){
	make DESTDIR="$D" install
	dosym /usr/share/icons/hicolor/scalable/apps/linnya.svg /usr/share/pixmaps/linnya.svg
}
