# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

EGIT_REPO_URI="git://github.com/phuang/ibus.git"
NEED_PYTHON="2.5"
inherit autotools multilib git python

DESCRIPTION="Intelligent Input Bus for Linux / Unix OS"
HOMEPAGE="http://ibus.googlecode.com"
SRC_URI=""

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="nls qt4"

# Notes:
# 1. Autopoint(part of gettext) needs cvs. Bug #152872
# 2. To run ibus, we don't need gettext.
COMMOM_DEPEND=">=dev-libs/glib-2
	dev-libs/dbus-glib
	qt4? ( x11-libs/qt-gui x11-libs/qt-core )
	x11-libs/gtk+:2
	x11-libs/libX11"
RDEPEND="${COMMOM_DEPEND}
	app-text/iso-codes
	>=dev-python/dbus-python-0.83.0
	|| (
		dev-python/gconf-python
		dev-python/gnome-python
	)
	>=dev-python/pygtk-2.12.1
	dev-python/pyxdg
	x11-misc/notification-daemon"
DEPEND="${COMMOM_DEPEND}
	dev-util/cvs
	dev-util/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	# An arch specific config directory is used on multilib systems
	has_multilib_profile && GTK2_CONFDIR="/etc/gtk-2.0/${CHOST}"
	GTK2_CONFDIR=${GTK2_CONFDIR:=/etc/gtk-2.0/}
}

src_prepare() {
	autopoint || die "failed to run autopoint"
	eautoreconf
}

src_configure() {
	# We never use the internal copy of gconf-python.
	econf $(use_enable nls) \
		$(use_enable qt4 qt4-immodule)
		--disable-pygconf
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"
	keepdir /usr/share/ibus/engine
	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	ewarn "This package is very experimental, please report your bugs to"
	ewarn "http://ibus.googlecode.com/issues/list"
	echo
	elog "To use ibus, you need to:"
	elog "1. Install input engines."
	elog "   Run \"emerge -s ibus-\" in your favorite terminal"
	elog "   for a list of IMEngines we already have."
	elog "2. Set the following in your"
	elog "   user startup scripts such as .xinitrc or .bashrc"
	echo
	elog "   export XMODIFIERS=\"@im=ibus\""
	elog "   export GTK_IM_MODULE=\"ibus\""
	elog "   export QT_IM_MODULE=\"ibus\""
	elog "   ibus &"
	echo
	if ! use qt4; then
		ewarn "Missing qt4 use flag, ibus will not work in qt4 applications."
		ebeep 3
	fi

	[ -x /usr/bin/gtk-query-immodules-2.0 ] && gtk-query-immodules-2.0 > \
		"${ROOT}/${GTK2_CONFDIR}/gtk.immodules"

	# Refer to: http://www.gentoo.org/proj/en/Python/developersguide.xml
	python_version
	python_mod_optimize "$(python_get_sitedir)"/${PN} /usr/share/${PN}
}

pkg_postrm() {
	[ -x /usr/bin/gtk-query-immodules-2.0 ] && gtk-query-immodules-2.0 > \
		"${ROOT}/${GTK2_CONFDIR}/gtk.immodules"

	python_mod_cleanup
	python_mod_cleanup /usr/share/${PN}
}
