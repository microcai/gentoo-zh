# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libappindicator/libappindicator-12.10.0.ebuild,v 1.4 2015/01/27 12:17:48 pacho Exp $

EAPI=5
VALA_MIN_API_VERSION="0.16"
VALA_USE_DEPEND="vapigen"

inherit eutils vala

DESCRIPTION="A library to allow applications to export a menu into the Unity Menu bar"
HOMEPAGE="http://launchpad.net/libappindicator"
SRC_URI="http://launchpad.net/${PN}/${PV%.*}/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-2.1 LGPL-3"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE="+introspection"

RDEPEND="
	dev-python/pygtk:2
	dev-python/pygobject:2
	>=dev-libs/dbus-glib-0.98
	>=dev-libs/glib-2.26:2
	>=dev-libs/libdbusmenu-12.10.2-r2[gtk,introspection?]
	>=dev-libs/libindicator-12.10.0:0
	>=x11-libs/gtk+-2.20:2[introspection?]
	introspection? ( >=dev-libs/gobject-introspection-1 )
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	introspection? ( $(vala_depend) )
"

src_prepare() {
	# Don't use -Werror
	sed -i -e 's/ -Werror//' {src,tests}/Makefile.{am,in} || die

	# Disable MONO for now because of http://bugs.gentoo.org/382491
	sed -i -e '/^MONO_REQUIRED_VERSION/s:=.*:=9999:' configure || die
	use introspection && vala_src_prepare
}

src_configure() {
	# http://bugs.gentoo.org/409133
#	export APPINDICATOR_PYTHON_CFLAGS='-I/usr/include/pygtk-2.0/'
#export APPINDICATOR_PYTHON_LIBS='-lpyglib-2.0-python2.72.7.so

	econf \
		--disable-silent-rules \
		--disable-static \
		--with-html-dir=/usr/share/doc/${PF}/html \
		--disable-introspection \
		--with-gtk=2
}

src_install() {
	emake -j1 DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog

	prune_libtool_files
}
