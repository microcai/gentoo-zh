# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

PYTHON_DEPEND="python? 2:2.5"
inherit eutils gnome2-utils multilib python git autotools

EGIT_REPO_URI="git://github.com/phuang/${PN}.git"

DESCRIPTION="Intelligent Input Bus for Linux / Unix OS"
HOMEPAGE="http://code.google.com/p/ibus/"
SRC_URI=""

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="doc nls gtk gconf +python vala"

RDEPEND=">=dev-libs/glib-2.18
	gconf? ( >=gnome-base/gconf-2.12.0 )
	>=gnome-base/librsvg-2
	app-text/iso-codes
	dev-libs/dbus-glib
	gtk? (
		x11-libs/libX11
		x11-libs/gtk+:2
	)
	python? (
		dev-python/notify-python
		>=dev-python/dbus-python-0.83
	)
	nls? ( virtual/libintl )
	vala? ( dev-lang/vala )"
DEPEND="${RDEPEND}
	>=dev-lang/perl-5.8.1
	dev-perl/XML-Parser
	dev-util/pkgconfig
	>=dev-util/gtk-doc-1.9
	dev-vcs/cvs
	>=dev-libs/gobject-introspection-0.6.8
	nls? ( >=sys-devel/gettext-0.16.1 )"
RDEPEND="${RDEPEND}
	python? (
		dev-python/pygtk
		dev-python/pyxdg
	)"
RESTRICT="test"

GNOME2_ECLASS_ICONS="usr/share/icons/hicolor"

update_gtk_immodules() {
	if [ -x /usr/bin/gtk-query-immodules-2.0 ] ; then
		GTK2_CONFDIR="/etc/gtk-2.0"
		# An arch specific config directory is used on multilib systems
		has_multilib_profile && GTK2_CONFDIR="${GTK2_CONFDIR}/${CHOST}"
		mkdir -p "${ROOT}${GTK2_CONFDIR}"
		gtk-query-immodules-2.0 > "${ROOT}${GTK2_CONFDIR}/gtk.immodules"
	fi
}

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	echo "AM_GNU_GETTEXT_VERSION(0.16.1)" >> "${S}"/configure.ac
	autopoint || die "autopoint failed"
	intltoolize --copy --force || die "intltoolize failed"
	gtkdocize --copy || die "gtkdocize failed"
	eautoreconf

	mv py-compile py-compile.orig || die
	ln -s "$(type -P true)" py-compile || die
	echo "ibus/_config.py" >> po/POTFILES.skip || die
	sed -i -e "s/python/python2/" setup/ibus-setup.in ui/gtk/ibus-ui-gtk.in || die
}

src_configure() {
	econf \
		$(use_enable doc gtk-doc) \
		$(use_enable nls) \
		$(use_enable gconf) \
		$(use_enable gtk gtk2) \
		$(use_enable gtk xim) \
		$(use_enable nls) \
		$(use_enable python) \
		$(use_enable vala) || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	# bug 289547
	keepdir /usr/share/ibus/{engine,icons}

	dodoc AUTHORS NEWS README
	rmdir "${S}"/usr/share/ibus/engine
}

pkg_postinst() {

	ewarn "This package is very experimental, please report your bugs to"
	ewarn "http://ibus.googlecode.com/issues/list"
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

	use gtk && update_gtk_immodules

	use python && python_mod_optimize /usr/share/${PN} "$(python_get_sitedir)"/${PN}
	gnome2_icon_cache_update
}

pkg_postrm() {
	use gtk && update_gtk_immodules

	use python && python_mod_cleanup /usr/share/${PN} "$(python_get_sitedir)"/${PN}
	gnome2_icon_cache_update
}
