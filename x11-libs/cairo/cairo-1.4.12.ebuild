# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils flag-o-matic libtool

DESCRIPTION="A vector graphics library with cross-device output support"
HOMEPAGE="http://cairographics.org/"
SRC_URI="http://cairographics.org/releases/${P}.tar.gz"

LICENSE="|| ( LGPL-2.1 MPL-1.1 )"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ~mips ppc ~ppc64 ~sh sparc x86 ~x86-fbsd"
IUSE="debug directfb doc glitz newspr opengl svg X xcb"

# Test causes a circular depend on gtk+... since gtk+ needs cairo but test needs gtk+ so we need to block it
RESTRICT="test"

RDEPEND="media-libs/fontconfig
		newspr? ( >=media-libs/freetype-2.3.1 )
		!newspr? ( >=media-libs/freetype-2.1.4 )
		media-libs/libpng
		X?	(
				x11-libs/libXrender
				x11-libs/libXext
				x11-libs/libX11
				x11-libs/libXft
				xcb? ( x11-libs/libxcb
						x11-libs/xcb-util )
			)
		directfb? ( >=dev-libs/DirectFB-0.9.24 )
		glitz? ( >=media-libs/glitz-0.5.1 )
		svg? ( dev-libs/libxml2 )"

DEPEND="${RDEPEND}
		>=dev-util/pkgconfig-0.19
		X? ( x11-proto/renderproto
			xcb? ( x11-proto/xcb-proto ) )
		doc?	(
					>=dev-util/gtk-doc-1.3
					 ~app-text/docbook-xml-dtd-4.2
				)"

src_unpack() {
	unpack ${A}
	cd "${S}"

	if use newspr; then
		epatch "${FILESDIR}/${PN}-1.4-newspr.patch.bz2"
	fi

	# We need to run elibtoolize to ensure correct so versioning on FreeBSD
	elibtoolize
}

pkg_setup() {
	if use newspr; then
		if ! built_with_use 'x11-libs/libXft' newspr; then
			echo
			ewarn "You must build x11-libs/libXft with \"newspr\" USE flag,"
			ewarn "otherwise, the \"newspr\" USE flag in cairo won't work!"
			echo
			ebeep 3
		fi
	fi
}

src_compile() {
	#gets rid of fbmmx.c inlining warnings
	append-flags -finline-limit=1200

	if use glitz && use opengl; then
		export glitz_LIBS=-lglitz-glx
	fi

	econf $(use_enable X xlib) $(use_enable doc gtk-doc) $(use_enable directfb) \
		  $(use_enable svg) $(use_enable glitz) \
		  $(use_enable debug test-surfaces) --enable-pdf  --enable-png \
		  --enable-freetype --enable-ps $(use_enable xcb) \
		  || die "configure failed"

	emake || die "compile failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
pkg_postinst() {
	ewarn "DO NOT report bugs to Gentoo's bugzilla"
	einfo "See http://forums.gentoo.org/viewtopic-t-511382.html for support topic on Gentoo forums."
	einfo "Thank you on behalf of the Gentoo Xeffects team"
}
