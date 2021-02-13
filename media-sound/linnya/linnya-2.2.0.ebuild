# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit eutils vcs-snapshot

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

src_configure(){
	./autogen
	./configure --prefix=/usr
}

src_install(){
	make DESTDIR="$D" install
	newicon data/${PN}.svg ${PN}.svg
}
