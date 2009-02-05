# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

NEED_PYTHON="2.5"
EGIT_REPO_URI="git://github.com/phuang/ibus.git"
inherit autotools multilib git python

DESCRIPTION="Intelligent Input Bus for Linux / Unix OS"
HOMEPAGE="http://ibus.googlecode.com"
SRC_URI=""

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="nls qt4 doc" # test

COMMOM_DEPEND=">=dev-libs/glib-2.18
	dev-libs/dbus-glib
	>=dev-python/pygobject-2.15
	>=gnome-base/gconf-2.11.1
	x11-libs/gtk+:2
	x11-libs/libX11
	sys-libs/glibc
	qt4? (
		x11-libs/qt-core
		x11-libs/qt-dbus
	)"
DEPEND="${COMMOM_DEPEND}
	dev-util/cvs
	dev-util/pkgconfig
	>=sys-devel/gettext-0.16.1
	>=dev-util/gtk-doc-1.9"
RDEPEND="${COMMOM_DEPEND}
	app-text/iso-codes
	>=dev-python/dbus-python-0.83.0
	>=dev-python/pygtk-2.12.1
	dev-python/pyxdg
	gnome-base/librsvg
	x11-misc/notification-daemon
	|| (
		dev-python/gconf-python
		dev-python/gnome-python
	)"

pkg_setup() {
	# An arch specific config directory is used on multilib systems
	has_multilib_profile && GTK2_CONFDIR="/etc/gtk-2.0/${CHOST}"
	GTK2_CONFDIR=${GTK2_CONFDIR:=/etc/gtk-2.0/}
}

src_prepare() {
	#FIXME:no stripping
	#sed -i -e "/TEMPLATE/ i\QMAKE_STRIP = true" client/qt4/${PN}.pro
	#cat client/qt4/${PN}.pro

	autopoint || die "autopoint failed"
	gtkdocize || die "gtkdocize failed"
	eautoreconf

	# disable pyc compiling
	mv py-compile py-compile.orig
	ln -s $(type -P true) py-compile
}

src_configure() {
	econf $(use_enable nls) \
		$(use_enable qt4 qt4-immodule) \
		$(use_enable doc gtk-doc) \
		--disable-iso-codes-check
}

src_install() {
	keepdir /usr/share/ibus/engine
	emake install DESTDIR="${D}" || die "Install failed"
	dodoc AUTHORS ChangeLog NEWS README
}

#src_test() {
#	PYTHONPATH="${D}/$(python_get_sitedir)/${PN}" "${python}" test/test_client.py || die "tests failed"
#}

pkg_postinst() {
	ewarn "This package is very experimental, please report your bugs to"
	ewarn "http://ibus.googlecode.com/issues/list"
	echo
	elog "User documentation: http://code.google.com/p/ibus/wiki/ReadMe"
	if ! use qt4; then
		ewarn "Missing qt4 use flag, ibus will not work with qt4 applications."
		ebeep 5
	fi

	[ -x /usr/bin/gtk-query-immodules-2.0 ] && gtk-query-immodules-2.0 > \
		"${ROOT}/${GTK2_CONFDIR}/gtk.immodules"

	# http://www.gentoo.org/proj/en/Python/developersguide.xml
	python_mod_optimize "$(python_get_sitedir)"/${PN} /usr/share/${PN}
}

pkg_postrm() {
	[ -x /usr/bin/gtk-query-immodules-2.0 ] && gtk-query-immodules-2.0 > \
		"${ROOT}/${GTK2_CONFDIR}/gtk.immodules"

	python_mod_cleanup && python_mod_cleanup /usr/share/${PN}
}
