# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

MY_PNV=${PN}-all-${PV}
CMAKE_MIN_VERSION="2.8"
inherit cmake-utils

DESCRIPTION="Free and open source implemention of Fetion protocol library and client"
HOMEPAGE="http://code.google.com/p/ofetion"
SRC_URI="http://ofetion.googlecode.com/files/${MY_PNV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gstreamer libnotify networkmanager xscreensaver"

RDEPEND="dev-db/sqlite:3
	dev-libs/glib:2
	dev-libs/libxml2
	dev-libs/openssl
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:2
	gstreamer? ( media-libs/gstreamer:0.10 )
	libnotify? ( x11-libs/libnotify )
	networkmanager? (
		net-misc/networkmanager
		dev-libs/dbus-glib
	)
	xscreensaver? ( x11-libs/libXScrnSaver )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/gettext"

RESTRICT="mirror"
S=${WORKDIR}/${MY_PNV}
DOCS=( AUTHORS README ChangeLog )
PATCHES=( "${FILESDIR}"/${PN}-fix-hardcode.patch )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with gstreamer GSTREAMER )
		$(cmake-utils_use_with libnotify LIBNOTIFY )
		$(cmake-utils_use_with networkmanager NETWORKMANAGER )
		$(cmake-utils_use_with xscreensaver XSCREENSAVER )
	)
	cmake-utils_src_configure
}
