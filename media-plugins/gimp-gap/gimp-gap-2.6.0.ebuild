# Copyright 1999-2021 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

inherit eutils flag-o-matic

DESCRIPTION="Gimp Animation Package"
SRC_URI="http://download.gimp.org/pub/gimp/plug-ins/v2.6/gap/${P}.tar.bz2"
HOMEPAGE="http://www.gimp.org/"

KEYWORDS="~x86 ~amd64 ~ppc"
SLOT="0"
LICENSE="GPL-2"
IUSE="mpeg xanim wavplay sox mp3 mplayer"

DEPEND=">=media-gfx/gimp-2.6
	mpeg? ( media-libs/xvid )"
RDEPEND="${DEPEND}
	wavplay? ( >=media-sound/wavplay-1.4 )
	mplayer? ( media-video/mplayer )
	xanim? ( >=media-video/xanim-2.80.1 )
	sox? ( >=media-sound/sox-12.17 )
	mp3? ( >=media-sound/lame-3.9 )"

src_compile() {
	epatch ${FILESDIR}/extern_lib_fix.patch
	econf --disable-libmpeg3 || die "econf failed"
	sed -i  's/^LDFLAGS = /LDFLAGS = -lm -lpthread /' gap/Makefile
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc AUTHORS ChangeLog* NEWS README
	docinto howto
	dodoc docs/howto/txt/*.txt
	docinto reference
	dodoc docs/reference/txt/*.txt
}
