# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

TAR_SUFFIX=tar.gz

inherit eutils autotools googlecode versionator

MY_PN=osdlyrics
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="An OSD lyric show supporting multiple media players and downloading."
SRC_URI="http://${PN}.googlecode.com/files/${MY_P}.${TAR_SUFFIX}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mpd xmms2"

RDEPEND="
	dev-libs/dbus-glib
	gnome-base/libglade
	net-misc/curl
	x11-libs/gtk+
	mpd? ( media-libs/libmpd )
	xmms2? ( media-sound/xmms2 )"
DEPEND="${RDEPEND}"

use_disable() {
	use $1 || echo "--disable-$1"
}

src_configure() {
	econf \
		$(use_disable mpd) \
		$(use_disable xmms2)
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS ChangeLog NEWS* README*
}
