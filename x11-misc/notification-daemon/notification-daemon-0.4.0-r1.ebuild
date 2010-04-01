# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

WANT_AUTOMAKE="1.9"

inherit gnome2 eutils

DESCRIPTION="Notifications daemon"
HOMEPAGE="http://www.galago-project.org/"
SRC_URI="http://www.galago-project.org/files/releases/source/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="gstreamer notify-osd"

RDEPEND=">=dev-libs/glib-2.4.0
		 >=x11-libs/gtk+-2.4.0
		 >=gnome-base/gconf-2.4.0
		 >=x11-libs/libsexy-0.1.3
		 >=dev-libs/dbus-glib-0.71
		 x11-libs/libwnck
		 ~x11-libs/libnotify-0.4.5
		 >=gnome-base/libglade-2
		 notify-osd? ( gnome-extra/notify-osd )
		 gstreamer? ( >=media-libs/gstreamer-0.10 )"
DEPEND="${RDEPEND}
		dev-util/intltool
		>=sys-devel/gettext-0.14
		!xfce-extra/xfce4-notifyd"

src_unpack() {
	gnome2_src_unpack
	cd "${S}" || die "cd failed"
	epatch "${FILESDIR}"/${P}-report-sound-capability.patch

	if use notify-osd; then
		epatch "${FILESDIR}"/${P}-no-dbus-service.patch
		(./autogen.sh) || die
	fi
}

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS"
	G2CONF="$(use_enable gstreamer sound gstreamer)"
}
