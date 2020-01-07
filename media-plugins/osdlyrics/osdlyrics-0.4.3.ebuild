# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

TAR_SUFFIX=tar.gz

inherit eutils autotools

HOMEPAGE="http://code.google.com/p/osd-lyrics/"

DESCRIPTION="An OSD lyric show supporting multiple media players and downloading."
SRC_URI="http://osd-lyrics.googlecode.com/files/${P}.${TAR_SUFFIX}"
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

src_prepare() {
	epatch "${FILESDIR}/${PN}-unknown-type-int64_t.patch"
}

src_configure() {
	econf $(use_disable mpd) $(use_disable xmms2) $(use_enable appindicator)
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS ChangeLog NEWS* README*
}
