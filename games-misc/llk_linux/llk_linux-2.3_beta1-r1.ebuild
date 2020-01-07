# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7
inherit eutils fdo-mime

MY_PV="${PV/_beta/beta}"
DESCRIPTION="llk for linux"
HOMEPAGE="http://llk-linux.sourceforge.net"
SRC_URI="${HOMEPAGE}/dist/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
RESTRICT="mirror"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libpng
	media-sound/esound
	x11-libs/gtk+:2"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-2.3"

EPATCH_SOURCE="${FILESDIR}/llk_linux-2.3-pthread.patch \
	${FILESDIR}/score-segv.patch"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch ${EPATCH_SOURCE}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	newmenu "${S}"/llk_linux.desktop llk_linux.desktop
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}
