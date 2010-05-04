# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit autotools subversion versionator

DESCRIPTION="An OSD lyric show supporting multiple media players and downloading."
HOMEPAGE="http://code.google.com/p/osd-lyrics/"
ESVN_REPO_URI="http://${PN}.googlecode.com/svn/trunk/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="mpd xmms2"

RDEPEND="
	dev-libs/dbus-glib
	gnome-base/libglade
	net-misc/curl
	x11-libs/gtk+
	mpd? ( media-libs/libmpd )
	xmms2? ( media-sound/xmms2 )"
DEPEND="${RDEPEND}"

src_prepare() {
	eautoreconf
}

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
