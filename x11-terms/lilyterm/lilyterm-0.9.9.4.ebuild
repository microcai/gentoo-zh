# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
inherit eutils toolchain-funcs

DESCRIPTION="A lightweight and easy to use libvte based X terminal emulator"
HOMEPAGE="http://lilyterm.luna.com.tw"
SRC_URI="${HOMEPAGE}/file/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug nls"

# According to information in the changelog, Gtk+ 3 support isn't complete
# so we're forcing Gtk+ 2.

RDEPEND="
	dev-libs/glib:2
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:2
	x11-libs/pango
	x11-libs/vte:0
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	sed -e "/^DOCDIR/s/\$(BINARY)/&-${PVR}/" \
		-i .default || die "sed failed"
	epatch "${FILESDIR}"/${P}-configure.patch
}

src_configure() {
	tc-export CC # used also by custom configure script
	./configure \
		--prefix="${EPREFIX}/usr" \
		--sysconfdir="${EPREFIX}/etc/xdg" \
		$(use_enable debug) \
		$(use_enable nls)
}

src_compile() {
	emake LDFLAGS="${LDFLAGS}" || die
}

src_install() {
	emake DESTDIR="${D}" \
		EXAMPLES_DIR="${EPREFIX}"usr/share/doc/${PF}/examples \
		install || die "emake install failed."
	rm "${ED}"usr/share/doc/${PF}/COPYING || die
	dodoc README TODO || die "dodoc failed"
}
