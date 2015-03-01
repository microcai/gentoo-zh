# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libdbusmenu/libdbusmenu-12.10.2.ebuild,v 1.5 2014/08/20 11:25:43 armin76 Exp $

EAPI=5

VALA_MIN_API_VERSION=0.16
VALA_USE_DEPEND=vapigen
PYTHON_COMPAT=( python{2_6,2_7} )

inherit eutils flag-o-matic python-single-r1 vala

DESCRIPTION="Library to pass menu structure across DBus"
HOMEPAGE="http://launchpad.net/dbusmenu"
SRC_URI="http://launchpad.net/${PN/lib}/${PV%.*}/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-2.1 LGPL-3"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug gtk +introspection"

RDEPEND="
	>=dev-libs/dbus-glib-0.100
	>=dev-libs/json-glib-0.13.4
	>=dev-libs/glib-2.32
	dev-libs/libxml2
	gtk? ( >=x11-libs/gtk+-2.20[introspection?] )
	introspection? ( >=dev-libs/gobject-introspection-1 )
	!<${CATEGORY}/${PN}-0.5.1-r200"
DEPEND="${RDEPEND}
	app-text/gnome-doc-utils
	dev-util/intltool
	virtual/pkgconfig
	introspection? ( $(vala_depend) )"

src_prepare() {
	if use introspection; then
		vala_src_prepare
		export VALA_API_GEN="${VAPIGEN}"
	fi
	python_fix_shebang tools
}

src_configure() {
	append-flags -Wno-error #414323

	# dumper extra tool is only for GTK+-2.x, tests use valgrind which is stupid
	econf \
		--docdir=/usr/share/doc/${PF} \
		--disable-static \
		--disable-silent-rules \
		--disable-scrollkeeper \
		$(use_enable gtk) \
		--disable-dumper \
		$(use_enable introspection) \
		$(use_enable introspection vala) \
		$(use_enable debug massivedebugging) \
		--with-html-dir=/usr/share/doc/${PF}/html \
		--with-gtk=2
}

src_test() { :; } #440192

src_install() {
	MAKEOPTS+=" -j1"
	default

	local a b
	for a in ${PN}-{glib,gtk}; do
		b=/usr/share/doc/${PF}/html/${a}
		[[ -d ${ED}/${b} ]] && dosym ${b} /usr/share/gtk-doc/html/${a}
	done

	prune_libtool_files
	
	cd ${D}
	rm -rf usr/include/libdbusmenu-glib-0.4/
	rm -rf usr/libexec
	rm -rf usr/share/libdbusmenu/json/test
	rm -rf usr/lib64/libdbusmenu-glib.so.4.0.12
	rm -rf usr/lib64/libdbusmenu-jsonloader.so.4.0.12
	rm -rf usr/lib64/pkgconfig/dbusmenu-jsonloader-0.4.pc
	rm -rf usr/lib64/pkgconfig/dbusmenu-glib-0.4.pc
	rm -rf usr/share/gtk-doc/html/libdbusmenu-gtk
	rm -rf usr/share/gtk-doc/html/libdbusmenu-glib
	rm -rf usr/lib64/libdbusmenu-jsonloader.so*
	rm -rf usr/lib64/libdbusmenu-glib.so*
	rm -rf usr/share/libdbusmenu/json/test-gtk-lab*

}
