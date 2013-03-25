# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ibus/ibus-1.4.2.ebuild,v 1.5 2013/01/29 03:19:16 naota Exp $

EAPI=4
PYTHON_DEPEND="python? 2:2.5"

inherit eutils gnome2-utils multilib python autotools

DESCRIPTION="Intelligent Input Bus for Linux / Unix OS"
HOMEPAGE="http://code.google.com/p/ibus/"
SRC_URI="http://ibus.googlecode.com/files/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="dconf doc +gconf gtk gtk3 +introspection nls +python vala +X"
REQUIRED_USE="|| ( gtk gtk3 X )" #342903

RDEPEND=">=dev-libs/glib-2.26
	dconf? ( >=gnome-base/dconf-0.7.5 )
	gconf? ( >=gnome-base/gconf-2.12:2 )
	gnome-base/librsvg
	sys-apps/dbus[X?]
	app-text/iso-codes
	gtk? ( x11-libs/gtk+:2 )
	gtk3? ( x11-libs/gtk+:3 )
	X? (
		x11-libs/libX11
		x11-libs/gtk+:2
	)
	introspection? ( >=dev-libs/gobject-introspection-0.6.8 )
	python? (
		dev-python/notify-python
		>=dev-python/dbus-python-0.83
	)
	nls? ( virtual/libintl )"
#	X? ( x11-libs/libX11 )
#	gtk? ( x11-libs/gtk+:2 x11-libs/gtk+:3 )
#	vala? ( dev-lang/vala )
DEPEND="${RDEPEND}
	>=dev-lang/perl-5.8.1
	dev-util/intltool
	virtual/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.9 )
	nls? ( >=sys-devel/gettext-0.16.1 )"
RDEPEND="${RDEPEND}
	python? (
		dev-python/pygtk
		dev-python/pyxdg
	)"

RESTRICT="test"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	if use python; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

src_prepare() {
	>py-compile #397497
	echo ibus/_config.py >> po/POTFILES.skip

	epatch \
		"${FILESDIR}"/${PN}-gconf-2.m4.patch \
		"${FILESDIR}"/${PN}-1.4.1-libxslt-1.1.27.patch
		
	epatch "${FILESDIR}/${PN}-1.4.2-newdconf.patch"

	eautoreconf
}

src_configure() {
	# We cannot call $(PYTHON) if we haven't called python_pkg_setup
	use python && PYTHON=$(PYTHON) || PYTHON=
	econf \
		$(use_enable dconf) \
		$(use_enable doc gtk-doc) \
		$(use_enable doc gtk-doc-html) \
		$(use_enable introspection) \
		$(use_enable gconf) \
		$(use_enable gtk gtk2) \
		$(use_enable gtk xim) \
		$(use_enable gtk3) \
		$(use_enable nls) \
		$(use_enable python) \
		$(use_enable vala) \
		$(use_enable X xim) \
		PYTHON="${PYTHON}"
}

src_install() {
	default

	find "${ED}" -name '*.la' -exec rm -f {} +

	insinto /etc/X11/xinit/xinput.d
	newins xinput-ibus ibus.conf

	keepdir /usr/share/ibus/{engine,icons} #289547
}

pkg_preinst() {
	use gconf && gnome2_gconf_savelist
	gnome2_icon_savelist
}

pkg_postinst() {
	use gconf && gnome2_gconf_install
	use gtk && gnome2_query_immodules_gtk2
	use gtk3 && gnome2_query_immodules_gtk3
	use python && python_mod_optimize /usr/share/${PN}
	gnome2_icon_cache_update

	elog "To use ibus, you should:"
	elog "1. Get input engines from sunrise overlay."
	elog "   Run \"emerge -s ibus-\" in your favorite terminal"
	elog "   for a list of packages we already have."
	elog
	elog "2. Setup ibus:"
	elog
	elog "   $ ibus-setup"
	elog
	elog "3. Set the following in your user startup scripts"
	elog "   such as .xinitrc, .xsession or .xprofile:"
	elog
	elog "   export XMODIFIERS=\"@im=ibus\""
	elog "   export GTK_IM_MODULE=\"ibus\""
	elog "   export QT_IM_MODULE=\"xim\""
	elog "   ibus-daemon -d -x"
}

pkg_postrm() {
	use gtk && gnome2_query_immodules_gtk2
	use gtk3 && gnome2_query_immodules_gtk3
	use python && python_mod_cleanup /usr/share/${PN}
	gnome2_icon_cache_update
}
