# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit eutils autotools versionator git-r3

HOMEPAGE="http://code.google.com/p/osd-lyrics/"

DESCRIPTION="An OSD lyric show supporting multiple media players and downloading."
EGIT_REPO_URI="https://github.com/osdlyrics/${PN}.git"
SRC_URI=""

if [ "${PV##*.}" = "9999" ]; then
	EGIT_BRANCH="master"
else
	EGIT_COMMIT="4e55d088c9306d2d6cd8"
fi

LICENSE="GPL-3"
SLOT="0"

if [ "${PV##*.}" = "9999" ]; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
fi

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
	epatch "${FILESDIR}/${PN}-unknown-type-int64_t.patch"
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
