# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="llk for linux"
HOMEPAGE="http://llk-linux.sourceforge.net/ \
http://linuxfans.org/nuke/modules.php?name=Forums&file=viewforum&f=65"
SRC_URI="http://llk-linux.sourceforge.net/dist/${PN}-2.3beta1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
RESTRICT="mirror"
KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND="media-libs/libpng
	media-sound/esound
	 >=x11-libs/gtk+-2.12"

RDEPEND="${DEPEND}"

EPATCH_SOURCE="${FILESDIR}/${P}-pthread.patch \
	${FILESDIR}/score-segv.patch"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch ${EPATCH_SOURCE}
}
src_compile() {
	einfo "Running autoreconf"
	built_with_use --missing die -o x11-libs/gtk+ jpeg || die "Please build gtk+ with USE=jpeg"
	cd "${S}"
	autoreconf -f -i || die "autoreconf failed"
	econf || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
