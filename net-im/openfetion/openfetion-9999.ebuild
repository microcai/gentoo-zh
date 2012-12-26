# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

CMAKE_MIN_VERSION="2.6"
EHG_PROJECT="openfetion"
EHG_REPO_URI="https://ofetion.googlecode.com/hg"
inherit cmake-utils mercurial

DESCRIPTION="Free and open source implementation of Fetion client based on GTK+2"
HOMEPAGE="http://code.google.com/p/ofetion"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="gstreamer libnotify networkmanager xscreensaver"

RDEPEND="dev-libs/glib:2
	~net-im/libofetion-${PV}
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

S=${WORKDIR}/${PN}
DOCS=( AUTHORS README ChangeLog )

src_unpack() {
	# workaround
	# http://sources.gentoo.org/cgi-bin/viewvc.cgi/gentoo-x86/eclass/mercurial.eclass?revision=1.15&view=markup
	local S=${WORKDIR}
	mercurial_src_unpack
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with gstreamer GSTREAMER )
		$(cmake-utils_use_with libnotify LIBNOTIFY )
		$(cmake-utils_use_with networkmanager NETWORKMANAGER )
		$(cmake-utils_use_with xscreensaver LIBXSS )
	)
	cmake-utils_src_configure
}
