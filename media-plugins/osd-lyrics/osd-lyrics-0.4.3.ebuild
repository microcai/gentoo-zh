# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

TAR_SUFFIX=tar.gz


MY_PN=osdlyrics
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}

inherit eutils autotools googlecode

DESCRIPTION="An OSD lyric show supporting multiple media players and downloading."
SRC_URI="http://${PN}.googlecode.com/files/${MY_P}.${TAR_SUFFIX}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+mpd +xmms2 -appindicator"

RDEPEND="
	dev-libs/dbus-glib
	net-misc/curl
	>=x11-libs/gtk+-2.20:2
	>=x11-libs/libnotify-0.7.1
	>=dev-db/sqlite-3.3
	mpd? ( media-libs/libmpd )
	xmms2? ( media-sound/xmms2 )
	appindicator? ( dev-libs/libappindicator )"
DEPEND="${RDEPEND}"

use_disable() {
	[[ -z $2 ]] && $2=$1
	use $1 || echo "--disable-$2"
}

src_configure() {
	econf $(use_disable mpd) $(use_disable xmms2) $(use_enable appindicator)
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS ChangeLog NEWS* README*
}
