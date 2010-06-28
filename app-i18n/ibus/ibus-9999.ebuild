# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit gnome2-utils multilib python git autotools

EGIT_REPO_URI="git://github.com/phuang/${PN}.git"

GNOME2_ECLASS_ICONS="usr/share/icons/hicolor"

DESCRIPTION="Intelligent Input Bus for Linux / Unix OS"
HOMEPAGE="http://code.google.com/p/ibus/"
SRC_URI=""

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="doc nls qt4 introspection"

RDEPEND=">=dev-libs/glib-2.18
	>=x11-libs/gtk+-2
	>=gnome-base/gconf-2.12.0
	>=gnome-base/librsvg-2
	>=sys-apps/dbus-1.2.4
	dev-libs/dbus-glib
	app-text/iso-codes
	x11-libs/libX11
	>=dev-lang/python-2.5
	>=dev-python/pygobject-2.14
	qt4? ( app-i18n/ibus-qt )
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	>=dev-lang/perl-5.8.1
	dev-perl/XML-Parser
	dev-util/pkgconfig
	>=dev-util/gtk-doc-1.9
	dev-vcs/cvs
	>=dev-libs/gobject-introspection-0.6.8
	nls? ( >=sys-devel/gettext-0.16.1 )"
RDEPEND="${RDEPEND}
	dev-python/pygtk
	dev-python/notify-python
	>=dev-python/dbus-python-0.83.0
	dev-python/pyxdg"

pkg_setup() {
	# An arch specific config directory is used on multilib systems
	has_multilib_profile && GTK2_CONFDIR="/etc/gtk-2.0/${CHOST}"
	GTK2_CONFDIR=${GTK2_CONFDIR:=/etc/gtk-2.0/}
}

src_prepare() {
	echo "AM_GNU_GETTEXT_VERSION(0.16.1)" >> "${S}"/configure.ac
	autopoint || die "autopoint failed"
	intltoolize --copy --force || die "intltoolize failed"
	gtkdocize --copy || die "gtkdocize failed"
	eautoreconf

	mv py-compile py-compile.orig || die
	ln -s "$(type -P true)" py-compile || die
}

src_configure() {
	econf \
		$(use_enable doc gtk-doc) \
		$(use_enable introspection introspection)\
		$(use_enable nls) || die
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

	[ "${ROOT}" = "/" -a -x /usr/bin/gtk-query-immodules-2.0 ] && \
		gtk-query-immodules-2.0 > "${ROOT}/${GTK2_CONFDIR}/gtk.immodules"

	python_mod_optimize /usr/share/${PN} "$(python_get_sitedir)"/${PN}
	gnome2_icon_cache_update
}

pkg_postrm() {
	[ "${ROOT}" = "/" -a -x /usr/bin/gtk-query-immodules-2.0 ] && \
		gtk-query-immodules-2.0 > "${ROOT}/${GTK2_CONFDIR}/gtk.immodules"

	python_mod_cleanup /usr/share/${PN} "$(python_get_sitedir)"/${PN}
	gnome2_icon_cache_update
}
