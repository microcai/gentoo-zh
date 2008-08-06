# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/dbus-python/dbus-python-0.82.4.ebuild,v 1.7 2008/08/01 17:54:40 nixnut Exp $

inherit python multilib

DESCRIPTION="Python bindings for the D-Bus messagebus."
HOMEPAGE="http://www.freedesktop.org/wiki/Software/DBusBindings \
http://dbus.freedesktop.org/doc/dbus-python/"
SRC_URI="http://dbus.freedesktop.org/releases/${PN}/${P}.tar.gz"

RESTRICT="mirror"
SLOT="0"
LICENSE="MIT"
KEYWORDS="alpha ~amd64 ~arm ~hppa ia64 ppc ~ppc64 ~s390 ~sh sparc x86 ~x86-fbsd"
IUSE="test"

RDEPEND=">=dev-lang/python-2.4.4-r5
	>=dev-python/pyrex-0.9.3-r2
	>=dev-libs/dbus-glib-0.71
	>=sys-apps/dbus-0.91"

DEPEND="${RDEPEND}
	test? ( dev-python/pygobject )
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# don't run py-compile
	sed -i \
		-e '/if test -n "$$dlist"; then/,/else :; fi/d' \
		Makefile.in || die "sed in Makefile.in failed"
}

src_compile() {
	econf --docdir=/usr/share/doc/dbus-python-${PV} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}

pkg_postinst() {
	python_version
	python_mod_optimize /usr/$(get_libdir)/python${PYVER}/site-packages/dbus
}

pkg_postrm() {
	python_mod_cleanup
}
