# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/muffin/muffin-1.0.2-r1.ebuild,v 1.4 2012/05/22 06:41:16 tetromino Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit eutils autotools gnome2 vcs-snapshot

DESCRIPTION="Compositing window manager forked from Mutter for use with Cinnamon"
HOMEPAGE="http://cinnamon.linuxmint.com/"

SRC_URI="https://github.com/linuxmint/muffin/tarball/${PV} -> ${P}.tar.gz"
		
LICENSE="GPL-2"
SLOT="0"
IUSE="test xinerama"
KEYWORDS="~amd64 ~x86"

COMMON_DEPEND=">=x11-libs/pango-1.2[X,introspection]
	>=x11-libs/cairo-1.10[X]
	x11-libs/gdk-pixbuf:2[introspection]
	>=x11-libs/gtk+-3.4:3[introspection]
	>=gnome-base/gconf-2:2
	>=dev-libs/glib-2.30
	>=media-libs/clutter-1.10[introspection]
	>=media-libs/libcanberra-0.26[gtk3]
	>=x11-libs/startup-notification-0.7
	>=x11-libs/libXcomposite-0.2

	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libXrender

	gnome-extra/zenity

	>=dev-libs/gobject-introspection-1.0
	xinerama? ( x11-libs/libXinerama )
"
DEPEND="${COMMON_DEPEND}
	>=app-text/gnome-doc-utils-0.8
	sys-devel/gettext
	virtual/pkgconfig
	>=dev-util/intltool-0.35
	test? ( app-text/docbook-xml-dtd:4.5 )
	xinerama? ( x11-proto/xineramaproto )
	x11-proto/xextproto
	x11-proto/xproto"
RDEPEND="${COMMON_DEPEND}
	!x11-misc/expocity"

#S="${WORKDIR}/linuxmint-muffin-08ffc65"

pkg_setup() {
	DOCS="AUTHORS ChangeLog HACKING MAINTAINERS NEWS README* *.txt doc/*.txt"
	G2CONF="${G2CONF}
		--disable-static
		--enable-gconf
		--enable-shape
		--enable-sm
		--enable-startup-notification
		--enable-xsync
		--enable-verbose-mode
		--enable-compile-warnings=maximum
		--with-libcanberra
		--enable-introspection
		$(use_enable xinerama)"
}

src_prepare(){
	cp ${DISTDIR}/muffin-marshal.h src/muffin-marshal.h

	gnome2_src_prepare

	eautoreconf
}

