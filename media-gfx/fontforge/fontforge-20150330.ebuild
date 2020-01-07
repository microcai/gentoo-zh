# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fontforge/fontforge-20120731.ebuild,v 1.3 2014/06/10 01:03:23 vapier Exp $

# Some notes for maintainers this package:
# 1. README-unix: freetype headers are required to make use of truetype debugger
# in fontforge.
# 2. --enable-{double,longdouble} these just make ff use more storage space. In
# normal fonts neither is useful. Leave off.
# 3. FontForge autodetects libraries but does not link with them. They are
# dynamically loaded at run time if fontforge found them at build time.
# --with-regular-link disables this behaviour. No reason to make it optional for
# users. http://fontforge.sourceforge.net/faq.html#libraries. To see what
# libraries fontforge thinks with use $ fontforge --library-status

EAPI=7

PYTHON_COMPAT=( python2_7 )
inherit eutils fdo-mime python-single-r1 autotools

DESCRIPTION="postscript font editor and converter"
HOMEPAGE="http://fontforge.github.io"

SRC_URI="https://github.com/fontforge/fontforge/releases/download/${PV}/fontforge-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"

IUSE="readline even debug +python truetype-debugger tiff tilepath png cjk unicode cairo gif jpeg +spiro tools nls +X zmq +gtk2"

RDEPEND="
	sys-libs/zlib
	>=dev-libs/glib-2.6
	>=dev-libs/libxml2-2.6.7
	>=media-libs/freetype-2.3.7

	cairo? ( >=x11-libs/cairo-1.6.4[X] )
	gif? ( >=media-libs/giflib-4.2.3-r1 )
	png? ( >=media-libs/libpng-1.6 )
	jpeg? ( virtual/jpeg:0 )
	tiff? ( >=media-libs/tiff-4.0 )
	unicode?  ( >=media-libs/libuninameslist-20140731 )
	readline? ( sys-libs/readline )
	spiro? ( media-libs/libspiro )
	python? ( ${PYTHON_DEPS} )
	truetype-debugger? ( >=media-libs/freetype-2.3.8[fontforge,-bindist] )

	X? ( >=x11-libs/pango-1.20.3[X]
		x11-libs/libXi
		x11-libs/libX11
		dev-libs/libxml2
		x11-proto/inputproto
	)
	gtk2? ( x11-libs/gtk+:2 >=x11-libs/pango-1.20.3 )
	zmq? ( net-libs/zeromq )
	!media-gfx/pfaedit
	"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	net-misc/wget
	dev-util/indent
	app-arch/unzip
"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )  even? ( python )"

#IUSE=" doc  pasteafter"

pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_prepare() {
	#mv ../uthash-* uthash
	#mv ../gnulib-0.1 gnulib
	use zmq && export LIBZMQ_LIBS=-lzmq
	
	pushd m4
	rm argz.m4
	popd

	./bootstrap --force
}

src_configure() {
	# no real way of disabling gettext/nls ...
	use zmq && export LIBZMQ_LIBS=-lzmq

	use nls || export ac_cv_header_libintl_h=no
	econf \
		$(use_enable debug) \
		$(use_enable debug debug-raw-points) \
		--disable-static --enable-extra-encodings \
		$(use_with truetype-debugger freetype-src "/usr/include/freetype2/internal4fontforge/") \
		$(use_enable cjk gb12345) \
		$(use_enable tools maintainer-tools)
		$(use_with python) \
		$(use_enable python pyextension) \
		$(use_with X x) \
		$(use_enable tilepath) \
		$(use_with gif giflib) \
		$(use_with jpeg libjpeg) \
		$(use_with png libpng) \
		$(use_with tiff libtiff)  \
		$(use_with cairo) \
		$(use_with spiro libspiro)  \
		$(use_with unicode libuninameslist)  \
		$(use_with zmq zeromq ) \
		$(use_enable even python-even) \
		$(use_enable gtk2 gtk2-use)
}

src_compile(){
	emake -C plugins

	default
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS README* || die

	prune_libtool_files
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
