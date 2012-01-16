# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gjs/gjs-1.30.0.ebuild,v 1.2 2011/11/15 09:06:58 nirbheek Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
PYTHON_DEPEND="2"

inherit gnome2 python virtualx

DESCRIPTION="Javascript bindings for GNOME"
HOMEPAGE="http://live.gnome.org/Gjs"

LICENSE="MIT MPL-1.1 LGPL-2 GPL-2"
SLOT="0"
IUSE="examples test"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-libs/glib-2.18:2
	>=dev-libs/gobject-introspection-1.29.16

	dev-libs/dbus-glib
	sys-libs/readline
	x11-libs/cairo
	>=dev-lang/spidermonkey-1.8.5"
DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/pkgconfig-0.9"

pkg_setup() {
	# AUTHORS, ChangeLog are empty
	DOCS="NEWS README"
	# FIXME: add systemtap/dtrace support, like in glib:2
	# FIXME: --enable-systemtap installs files in ${D}/${D} for some reason
	# XXX: Do NOT enable coverage, completely useless for portage installs
	G2CONF="${G2CONF}
		--disable-systemtap
		--disable-dtrace
		--disable-coverage"

	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	gnome2_src_prepare
	python_convert_shebangs 2 "${S}"/scripts/make-tests
}

src_test() {
	# Tests need dbus
	Xemake check || die
}

src_install() {
	# installation sometimes fails in parallel
	gnome2_src_install -j1

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins ${S}/examples/* || die "doins examples failed!"
	fi
}
