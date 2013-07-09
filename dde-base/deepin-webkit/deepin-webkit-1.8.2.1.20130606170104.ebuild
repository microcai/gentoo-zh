# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit versionator autotools eutils flag-o-matic gnome2-utils pax-utils virtualx

MY_VER="$(get_version_component_range 1-4)+git$(get_version_component_range 5)~fe5e99a5d0"
DESCRIPTION="A fork of webkit-gtk for deepin-desktop-eviroment"
HOMEPAGE="http://www.webkitgtk.org/"
SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/d/${PN}/${PN}_${MY_VER}.tar.gz"

LICENSE="LGPL-2+ BSD"
SLOT="3"
KEYWORDS="~amd64 ~x86"
IUSE="aqua coverage debug +geoloc +gstreamer +introspection +jit spell +webgl"
# bugs 372493, 416331
REQUIRED_USE="introspection? ( geoloc gstreamer )"

# use sqlite, svg by default
# Aqua support in gtk3 is untested
# gtk2 is needed for plugin process support
# FIXME: with-acceleration-backend is left automagic
RDEPEND="
	dev-libs/libxml2:2
	dev-libs/libxslt
	virtual/jpeg
	>=media-libs/libpng-1.4:0
	>=x11-libs/cairo-1.10
	>=dev-libs/glib-2.31.2:2
	x11-libs/gtk+:3[aqua=,introspection?]
	dev-libs/icu
	>=net-libs/libsoup-2.37.2.1:2.4[introspection?]
	dev-db/sqlite:3
	>=x11-libs/pango-1.21
	x11-libs/libXrender
	>=x11-libs/gtk+-2.24.3:2

	geoloc? ( app-misc/geoclue )
	gstreamer? (
		media-libs/gstreamer:1.0
		media-libs/gst-plugins-base:1.0 )
	introspection? ( >=dev-libs/gobject-introspection-0.9.12 )
	spell? ( app-text/enchant )
	webgl? (
		virtual/opengl
		x11-libs/libXcomposite
		x11-libs/libXdamage )
"
# paxctl needed for bug #407085
DEPEND="${RDEPEND}
	dev-lang/perl
	=dev-lang/python-2*
	|| ( virtual/rubygems[ruby_targets_ruby19]
	     virtual/rubygems[ruby_targets_ruby18] )
	app-accessibility/at-spi2-core
	>=dev-util/gtk-doc-am-1.10
	dev-util/gperf
	sys-devel/bison
	sys-devel/flex
	sys-devel/gettext
	>=sys-devel/make-3.82-r4
	virtual/pkgconfig

	introspection? ( jit? ( sys-apps/paxctl ) )
	test? ( 
		x11-themes/hicolor-icon-theme 
		jit? ( sys-apps/paxctl ) )
"
# Need real bison, not yacc

S="${WORKDIR}/${PN}-${MY_VER}"

src_prepare() {
    # USE=-gstreamer build failure, bug #412221, https://bugs.webkit.org/show_bug.cgi?id=84526
    epatch "${FILESDIR}/webkit-gtk-1.8.1-CodeGeneratorGObject-properties.patch"

    # bug #416057; in 1.9.x
    epatch "${FILESDIR}/webkit-gtk-1.8.1-gst-required-version.patch"

    # bug #428012; in 1.9.x
    epatch "${FILESDIR}/webkit-gtk-1.8.2-bison-2.6.patch"

# intermediate MacPorts hack while upstream bug is not fixed properly
    # https://bugs.webkit.org/show_bug.cgi?id=28727
    use aqua && epatch "${FILESDIR}"/webkit-gtk-1.6.1-darwin-quartz.patch

    # Bug #403049, https://bugs.webkit.org/show_bug.cgi?id=79605
    epatch "${FILESDIR}/webkit-gtk-1.7.5-linguas.patch"

    # Drop DEPRECATED flags
    sed -i -e 's:-D[A-Z_]*DISABLE_DEPRECATED:$(NULL):g' GNUmakefile.am || die

    # Don't force -O2
    sed -i 's/-O2//g' "${S}"/configure.ac || die

    # Build-time segfaults under PaX with USE="introspection jit", bug #404215
    if use introspection && use jit; then
        epatch "${FILESDIR}/deepin-webkit-1.6.3-paxctl-introspection.patch"
        cp "${FILESDIR}/gir-paxctl-lt-wrapper" "${S}/" || die
    fi

	# We need to reset some variables to prevent permissions problems and failures
	# like https://bugs.webkit.org/show_bug.cgi?id=35471 and bug #323669
	gnome2_environment_reset

	# For >=sys-devel/automake-1.12 compability wrt #420591
	#sed -i -e 's:mkdir_p:MKDIR_P:' {.,Source/WebKit/gtk/po}/GNUmakefile.am || die

	# Respect CC, otherwise fails on prefix #395875
	tc-export CC

	# Prevent maintainer mode from being triggered during make
	#AT_M4DIR=Source/autotools eautoreconf

}

src_configure() {
	local myconf

	# XXX: Check Web Audio support
	# XXX: dependency-tracking is required so parallel builds won't fail
	myconf="
		$(use_enable coverage)
		$(use_enable debug)
		$(use_enable debug debug-features)
		$(use_enable geoloc geolocation)
		$(use_enable spell spellcheck)
		$(use_enable introspection)
		$(use_enable gstreamer video)
		$(use_enable jit)
		$(use_enable webgl)
		--with-gtk=3.0
		--with-gstreamer=0.10
		--enable-accelerated-compositing
		--enable-dependency-tracking
		--disable-gtk-doc
		PYTHON=$(type -P python2)
		"$(usex aqua "--with-font-backend=pango --with-target=quartz" "")
		# Aqua support in gtk3 is untested

	if has_version "virtual/rubygems[ruby_targets_ruby19]"; then
		myconf="${myconf} RUBY=$(type -P ruby19)"
	else
		myconf="${myconf} RUBY=$(type -P ruby18)"
	fi

	econf ${myconf}
}

src_compile() {
	# Avoid parallel make failure with -j9
	emake DerivedSources/WebCore/JSNode.h
	default
}

src_test() {
	# Tests expect an out-of-source build in WebKitBuild
	ln -s . WebKitBuild || die "ln failed"
	
	# Prevents test failures on PaX systems
	use jit && pax-mark m $(list-paxables Programs/*[Tt]ests/*) \
	  	Programs/unittests/.libs/test*
	unset DISPLAY
	# Tests need virtualx, bug #294691, bug #310695
	# Parallel tests sometimes fail
	Xemake -j1 check
}

src_install() {
	default

	# Remove the conflited files with webkit-gtk
	rm -r ${D}usr/bin
	rm -r ${D}usr/include
	rm -r ${D}usr/share
	mv ${D}usr/$(get_libdir)/pkgconfig/webkitgtk-3.0.pc \
		${D}usr/$(get_libdir)/pkgconfig/deepin-webkit-3.0.pc
	rm -r ${D}usr/$(get_libdir)/girepository-1.0

	dodoc ${S}/ChangeLog

	prune_libtool_files

}
