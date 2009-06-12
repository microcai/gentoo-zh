# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#EAPI="2"

inherit eutils flag-o-matic libtool

DESCRIPTION="A vector graphics library with cross-device output support"
HOMEPAGE="http://cairographics.org/"
SRC_URI="http://cairographics.org/releases/${P}.tar.gz"

LICENSE="|| ( LGPL-2.1 MPL-1.1 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="cleartype debug directfb doc glitz opengl svg ubuntu X xcb"

# Test causes a circular depend on gtk+... since gtk+ needs cairo but test needs gtk+ so we need to block it
RESTRICT="test"

RDEPEND="media-libs/fontconfig
	>=media-libs/freetype-2.1.9
	sys-libs/zlib
	media-libs/libpng
	>=x11-libs/pixman-0.12.0
	directfb? ( >=dev-libs/DirectFB-0.9.24 )
	glitz? ( >=media-libs/glitz-0.5.1 )
	svg? ( dev-libs/libxml2 )
	X? ( 	>=x11-libs/libXrender-0.6
		x11-libs/libXext
		x11-libs/libX11
		x11-libs/libXft )
	xcb? (	>=x11-libs/libxcb-0.92
		x11-libs/xcb-util )"

#   ubuntu? ( >=media-libs/freetype-2.1.9[-cleartype] )
#   cleartype? ( >=media-libs/freetype-2.1.9[-ubuntu] )

#       ubuntu? ( x11-libs/libXft[-cleartype] )
#       cleartype? ( x11-libs/libXft[-ubuntu] )

#	test? (
#	pdf test
#	x11-libs/pango
#	>=x11-libs/gtk+-2.0
#	>=app-text/poppler-bindings-0.9.2
#	ps test
#	virtual/ghostscript
#	svg test
#	>=x11-libs/gtk+-2.0
#	>=gnome-base/librsvg-2.15.0

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.19
	doc? (	>=dev-util/gtk-doc-1.6
		~app-text/docbook-xml-dtd-4.2 )
	X? ( x11-proto/renderproto )
	xcb? ( x11-proto/xcb-proto )"

pkg_setup() {
#	if ! built_with_use app-text/poppler-bindings gtk ; then
#		eerror 'poppler-bindings with gtk is required for the pdf backend'
#		die 'poppler-bindings built without gtk support'
#	fi

	if use cleartype && use ubuntu; then
		eerror "The cleartype and ubuntu useflags are mutually exclusive,"
		eerror "you must disable one of them."
		die "Either disable the cleartype or the ubuntu useflag."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-respect-fontconfig.patch

	epatch "${FILESDIR}"/${PN}-1.8.6-status-return-fix.patch

	if use cleartype; then
		# ClearType-like patches applied by ArchLinux
		epatch "${FILESDIR}"/${PN}-1.2.4-lcd-cleartype-like.diff
	elif use ubuntu; then
		epatch "${FILESDIR}"/${PN}-ubuntu-02_no-private-symbol-export.patch
		epatch "${FILESDIR}"/${PN}-ubuntu-03_only_destroy_FT_Faces_created_by_cairo.patch
		epatch "${FILESDIR}"/${PN}-ubuntu-04_lcd_filter.patch
		epatch "${FILESDIR}"/${PN}-ubuntu-06_Xlib-Xcb-Hand-off-EXTEND_PAD-to-XRender.patch
	fi

	# We need to run elibtoolize to ensure correct so versioning on FreeBSD
	elibtoolize
}

src_compile() {
	#gets rid of fbmmx.c inlining warnings
	append-flags -finline-limit=1200

	if use glitz && use opengl; then
		export glitz_LIBS=$(pkg-config --libs glitz-glx)
	fi

	econf $(use_enable X xlib) $(use_enable doc gtk-doc) \
		$(use_enable directfb) $(use_enable xcb) \
		$(use_enable svg) $(use_enable glitz) $(use_enable X xlib-xrender) \
		$(use_enable debug test-surfaces) --enable-pdf  --enable-png \
		--enable-ft --enable-ps \
		|| die "configure failed"

	emake || die "compile failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"
	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	if use xcb; then
		ewarn "You have enabled the Cairo XCB backend which is used only by"
		ewarn "a select few apps. The Cairo XCB backend is presently"
		ewarn "un-maintained and needs a lot of work to get it caught up"
		ewarn "to the Xrender and Xlib backends, which are the backends used"
		ewarn "by most applications. See:"
		ewarn "http://lists.freedesktop.org/archives/xcb/2008-December/004139.html"
	fi
	echo
	ewarn "DO NOT report bugs to Gentoo's bugzilla"
	ewarn "See http://forums.gentoo.org/viewtopic-t-511382.html for support topic on Gentoo forums."
	echo
}
