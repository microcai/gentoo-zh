# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-control-center/gnome-control-center-2.26.0.ebuild,v 1.3 2009/05/21 19:27:28 nirbheek Exp $

EAPI="2"

inherit autotools eutils gnome2

DESCRIPTION="The gnome2 Desktop configuration tool"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="eds hal policykit"

RDEPEND="x11-libs/libXft
	>=x11-libs/gtk+-2.13.1
	>=dev-libs/glib-2.17.4
	>=gnome-base/gconf-2.0
	>=gnome-base/libglade-2
	>=gnome-base/librsvg-2.0
	>=gnome-base/nautilus-2.6
	>=media-libs/fontconfig-1
	>=dev-libs/dbus-glib-0.73
	>=x11-libs/libxklavier-3.6
	>=x11-wm/metacity-2.23.1
	>=gnome-base/gnome-panel-2.0
	>=gnome-base/libgnomekbd-2.21.4.1
	>=gnome-base/gnome-desktop-2.25.1
	>=gnome-base/gnome-menus-2.11.1
	gnome-base/gnome-settings-daemon

	x11-libs/pango
	dev-libs/libxml2
	media-libs/freetype
	>=media-libs/libcanberra-0.4[gtk]

	eds? ( >=gnome-extra/evolution-data-server-1.7.90 )
	hal? ( >=sys-apps/hal-0.5.6 )
	policykit? ( gnome-extra/policykit-gnome )

	>=gnome-base/libbonobo-2
	>=gnome-base/libgnome-2.2
	>=gnome-base/libbonoboui-2
	>=gnome-base/libgnomeui-2.2

	x11-apps/xmodmap
	x11-libs/libXScrnSaver
	x11-libs/libXext
	x11-libs/libX11
	x11-libs/libXxf86misc
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXcursor"
DEPEND="${RDEPEND}
	x11-proto/scrnsaverproto
	x11-proto/xextproto
	x11-proto/xproto
	x11-proto/xf86miscproto
	x11-proto/kbproto
	x11-proto/randrproto
	x11-proto/renderproto

	sys-devel/gettext
	>=dev-util/intltool-0.40
	>=dev-util/pkgconfig-0.19
	dev-util/desktop-file-utils

	app-text/scrollkeeper
	>=app-text/gnome-doc-utils-0.10.1
	gnome-base/gnome-common"
# Needed for autoreconf

DOCS="AUTHORS ChangeLog NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-update-mimedb
		--enable-canberra
		$(use_enable eds aboutme)
		$(use_enable hal)
		$(use_enable policykit policykit-gnome)"
}

src_prepare() {
	gnome2_src_prepare

	# Fix compilation on fbsd, bug #256958
	epatch "${FILESDIR}/${PN}-2.24.0.1-fbsd.patch"

	# Fix libcanberra and policykit-gnome for about-me capplet
	# automagics support, bug #266110
	epatch "${FILESDIR}/${P}-automagics-canberra+polkit.patch"

	# Policykit-based solution to setting the default background.  Must be
	# applied *after* teh automagics patch
	epatch "${FILESDIR}"/${P}-default-background.patch

	# Fix gnome-mouse-property segfaults, bug #270319,
	# merge from offical git
	epatch "${FILESDIR}"/${P}-git.patch

	eautoreconf
}

src_install() {
	gnome2_src_install

	if use policykit ; then
		# Install the policy for default backgrounds
		insinto /usr/share/PolicyKit/policy/
		doins "${FILESDIR}"/org.gnome.control-center.defaultbackground.policy
	fi
}
