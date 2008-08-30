# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
inherit eutils

DESCRIPTION="Next Generation Input Framework for Linux"
HOMEPAGE="http://ibus.googlecode.com"
SRC_URI="http://ibus.googlecode.com/files/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="nls qt4"

DEPEND="dev-lang/python:2.5
	dev-libs/dbus-glib
	qt4? (
		|| ( ( x11-libs/qt-gui x11-libs/qt-core ) ( >=x11-libs/qt-4.3.2 ) )
	)
	nls? ( sys-devel/gettext )
	x11-libs/gtk+:2"
RDEPEND=">=dev-python/dbus-python-0.83.0
	dev-python/gnome-python
	>=dev-python/pygtk-2.12.1
	dev-python/pyxdg"

get_gtk_confdir() {
	if use amd64 || ( [ "${CONF_LIBDIR}" == "lib32" ] && use x86 ) ;
	then
		echo "/etc/gtk-2.0/${CHOST}"
	else
		echo "/etc/gtk-2.0"
	fi
}

src_compile() {
	local myconf="--disable-option-checking \
		--enable--maintainer-mode"
	econf $myconf \
		$(use_enable nls) \
		$(use_enable qt4 qt4-immodule) \
		|| die "config failed"
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"
	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	ewarn "This is a highly experimental package, please report your bug here:"
	ewarn "http://ibus.googlecode.com/issues/list"
	elog
	elog "To use ibus, you should:"
	elog "1. Get an IM Engine from gentoo-china-overlay."
	elog "   Run \"emerge -s ibus-\" in your favorite terminal"
	elog "   for a list of packages we already have."
	elog "2. Set the following in your"
	elog "   user startup scripts such as .xinitrc or .bashrc"
	elog
	elog "   export XMODIFIERS=\"@im=ibus\""
	elog "   export GTK_IM_MODULE=\"ibus\""
	elog "   export QT_IM_MODULE=\"ibus\""
	elog "   ibus &"
	if ! use qt4; then
		ewarn "Missing qt4 use flag, Ibus will not work with qt4 applications."
		ebeep 3
	fi
	elog

	[ -x /usr/bin/gtk-query-immodules-2.0 ] && gtk-query-immodules-2.0 > "${ROOT}$(get_gtk_confdir)/gtk.immodules"
}

pkg_postrm() {
	[ -x /usr/bin/gtk-query-immodules-2.0 ] && gtk-query-immodules-2.0 > "${ROOT}$(get_gtk_confdir)/gtk.immodules"
}
