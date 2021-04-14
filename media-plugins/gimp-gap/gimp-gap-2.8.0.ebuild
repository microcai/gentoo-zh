# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

MY_PV=$(ver_cut 1)-$(ver_cut 2)
DESCRIPTION="Gimp Animation Package"
SRC_URI="https://github.com/GNOME/gimp-gap/archive/refs/heads/gap-${MY_PV}.zip"
HOMEPAGE="http://www.gimp.org/"

KEYWORDS="~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE="mpeg xanim wavplay sox mp3 mplayer"

S=${WORKDIR}/${PN}-gap-${MY_PV}

DEPEND=">=media-gfx/gimp-2.8
	mpeg? ( media-libs/xvid )"
RDEPEND="${DEPEND}
	wavplay? ( >=media-sound/wavplay-1.4 )
	mplayer? ( media-video/mplayer )
	xanim? ( >=media-video/xanim-2.80.1 )
	sox? ( >=media-sound/sox-12.17 )
	mp3? ( >=media-sound/lame-3.9 )"

src_configure() {
	./autogen.sh --prefix=/usr --disable-libmpeg3 --disable-gui-thread-support || die "autogen.sh failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc AUTHORS ChangeLog* NEWS README
	docinto howto
	dodoc docs/howto/txt/*.txt
	docinto reference
	dodoc docs/reference/txt/*.txt
}
