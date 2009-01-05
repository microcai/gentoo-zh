# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit eutils flag-o-matic libtool

DESCRIPTION="A vector graphics library with cross-device output support"
HOMEPAGE="http://cairographics.org/"
SRC_URI="http://cairographics.org/releases/${P}.tar.gz"

LICENSE="|| ( LGPL-2.1 MPL-1.1 )"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ~mips ppc ppc64 ~sh sparc x86 ~x86-fbsd"
IUSE="debug directfb doc glitz +newspr opengl svg test X xcb"

RDEPEND="newspr? (
			>=media-libs/freetype-2.3.5-r2
			>=media-libs/fontconfig-2.6.0
			)
		 !newspr? (
			media-libs/fontconfig
			media-libs/freetype:2
			)
		 sys-libs/zlib
		 media-libs/libpng
		 >=x11-libs/pixman-0.10.0
		 X? (
			  x11-libs/libXrender
			  x11-libs/libXext
			  x11-libs/libX11
			  x11-libs/libXft
			  xcb? (
					 x11-libs/libxcb
					 x11-libs/xcb-util
				   )
			)
		 directfb? ( >=dev-libs/DirectFB-0.9.24 )
		 glitz? ( >=media-libs/glitz-0.5.1 )
		 svg? ( dev-libs/libxml2 )"

DEPEND="${RDEPEND}
		>=dev-util/pkgconfig-0.19
		test? (
				virtual/ghostscript
				>=app-text/poppler-bindings-0.4.1
				x11-libs/pango
				x11-libs/gtk+
				svg? ( >=gnome-base/librsvg-2.15.0 )
			  )
		X? (
			 x11-proto/renderproto
			 xcb? ( x11-proto/xcb-proto )
		   )
		doc? (
			   >=dev-util/gtk-doc-1.6
			   app-text/docbook-xml-dtd:4.2
			 )"

RESTRICT="test"

pkg_setup () {
	if use newspr && \
		! built_with_use --missing false x11-libs/libXft newspr; then
		eerror "You need to rebuild libXft with newspr USE enabled"
		eerror "before you can compile cairo with newspr."
		die "Please rebuild libXft with newspr enabled."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# libpng's API changed as of 1.2.30, this is backwards compat with
	# older libpng's as well. bug #235072
	epatch "${FILESDIR}"/${PN}-1.6.4-libpng-api-change.patch

	if use newspr; then
		epatch "${FILESDIR}"/${PN}-1.6.4-0ubuntu1.diff.bz2 || die
	fi

	# for embedded bitmap font
	epatch "${FILESDIR}/${PN}"-1.6.4-freetype-Fake-bitmap-glyph-on-certain-condition.patch.bz2 || die

	# We need to run elibtoolize to ensure correct so versioning on FreeBSD
	elibtoolize
}

src_compile() {
	local use_xcb
	#gets rid of fbmmx.c inlining warnings
	append-flags -finline-limit=1200

	if use glitz && use opengl; then
		export glitz_LIBS=-lglitz-glx
	fi

	use_xcb="--disable-xcb"
	use X && use xcb && use_xcb="--enable-xcb"

	econf $(use_enable X xlib) $(use_enable doc gtk-doc) \
		$(use_enable directfb) ${use_xcb} \
		$(use_enable svg) $(use_enable glitz) $(use_enable X xlib-xrender) \
		$(use_enable debug test-surfaces) --enable-pdf  --enable-png \
		--enable-freetype --enable-ps \
		|| die "configure failed"

	emake || die "compile failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"
	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	elog "DO NOT report bugs to Gentoo's bugzilla"
	elog "See http://forums.gentoo.org/viewtopic-t-511382.html for support topic on Gentoo forums."
}
