# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit eutils unpacker

DESCRIPTION="netease cloud music player"
HOMEPAGE="http://music.163.com/"
SRC_URI="
	x86? ( http://s1.music.126.net/download/pc/netease-cloud-music_${PV}-2_i386.deb )
	amd64? ( http://s1.music.126.net/download/pc/netease-cloud-music_${PV}-2_amd64.deb )
"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror strip"

DEPEND="
	dev-libs/nss
	dev-qt/qtmultimedia
	dev-qt/qtx11extras
	media-libs/alsa-lib
	media-libs/gst-plugins-ugly
	media-libs/taglib
	x11-libs/gtk+
	x11-libs/libXScrnSaver
"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_prepare() {
	epatch "${FILESDIR}/fix_desktop.patch"
}

src_install() {
	exeinto /usr/bin
	exeopts -m0755
	doexe "${S}/usr/bin/netease-cloud-music"
	
	insinto /
	doins -r "${S}/usr"

	fperms 0755 /usr/lib/netease-cloud-music/netease-cloud-music
}
