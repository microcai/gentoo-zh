# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit autotools eutils gnome2

DESCRIPTION="The GNOME panel"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 FDL-1.1 LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc ~x86 ~x86-fbsd"
IUSE="doc eds"

RDEPEND=">=gnome-base/gnome-desktop-2.12
	>=x11-libs/pango-1.15.4
	>=dev-libs/glib-2.13.0
	>=x11-libs/gtk+-2.11.3
	>=gnome-base/libglade-2.5
	>=gnome-base/libgnome-2.13
	>=gnome-base/libgnomeui-2.5.4
	>=gnome-base/libbonoboui-2.1.1
	>=gnome-base/orbit-2.4
	>=gnome-base/gnome-vfs-2.14.2
	>=x11-libs/libwnck-2.19.5
	>=gnome-base/gconf-2.6.1
	>=gnome-base/gnome-menus-2.11.1
	>=gnome-base/libbonobo-2
	>=dev-libs/dbus-glib-0.71
	>=x11-libs/liblunar-1.0.0
	x11-libs/libXau
	media-libs/libpng
	>=x11-libs/cairo-1.0.0
	eds? ( >=gnome-extra/evolution-data-server-1.6 )"
DEPEND="${RDEPEND}
	app-text/scrollkeeper
	virtual/pkgconfig
	>=dev-util/intltool-0.35
	>=app-text/gnome-doc-utils-0.3.2
	~app-text/docbook-xml-dtd-4.1.2
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog HACKING NEWS README"

pkg_setup() {
	G2CONF="--disable-scrollkeeper $(use_enable eds) \
			--with-in-process-applets=clock,notification-area,wncklet --enable-lunar"
}

src_unpack() {
	unpack ${A}
	P="gnome-panel-2.20.3"
	S="`pwd`/${P}"
	cd ${S};

	# FIXME : uh yeah, this is nice
	# We should patch in a switch here and send it upstream
	# sed -i 's:--load:-v:' "${S}/gnome-panel/Makefile.in" || die "sed failed"
	sed -i 's:--load:-v:' "${S}/gnome-panel/Makefile.in" || die "sed failed"

	# Fix LINGUAS
	sed -i "2,2 s/ /\n/g" po/LINGUAS || die "Fixing LINGUAS failed"
	epatch ${FILESDIR}/lunar.patch
	gnome-autogen.sh

}

pkg_postinst() {
	local entries="/etc/gconf/schemas/panel-default-setup.entries"

	if [ -e "$entries" ]; then
		einfo "setting panel gconf defaults..."
		GCONF_CONFIG_SOURCE=`"${ROOT}usr/bin/gconftool-2" --get-default-source`
		"${ROOT}usr/bin/gconftool-2" --direct --config-source \
			"${GCONF_CONFIG_SOURCE}" --load="${entries}"
	fi

	# Calling this late so it doesn't process the GConf schemas file we already
	# took care of.
	gnome2_pkg_postinst
}
