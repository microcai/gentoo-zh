# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/pango/pango-1.22.3.ebuild,v 1.1 2008/11/24 15:27:15 leio Exp $

inherit eutils gnome2 multilib

DESCRIPTION="Text rendering and layout library"
HOMEPAGE="http://www.pango.org/"

LICENSE="LGPL-2 FTL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="X debug doc"

RDEPEND=">=dev-libs/glib-2.17.3
		 >=media-libs/fontconfig-1.0.1
		 >=media-libs/freetype-2
		 >=x11-libs/cairo-1.7.6
		 X? (
				x11-libs/libXrender
				x11-libs/libX11
				x11-libs/libXft
			)"
DEPEND="${RDEPEND}
		>=dev-util/pkgconfig-0.9
		doc? (
				>=dev-util/gtk-doc-1
				~app-text/docbook-xml-dtd-4.1.2
			 )
		X? ( x11-proto/xproto )"

DOCS="AUTHORS ChangeLog* NEWS README TODO*"

function multilib_enabled() {
	has_multilib_profile || ( use x86 && [ "$(get_libdir)" == "lib32" ] )
}

pkg_setup() {
	# Do NOT build with --disable-debug/--enable-debug=no
	if use debug ; then
		G2CONF="${G2CONF} --enable-debug=yes"
	fi

	G2CONF="${G2CONF} $(use_with X x)"
}

src_unpack() {
	gnome2_src_unpack

	# make config file location host specific so that a 32bit and 64bit pango
	# wont fight with each other on a multilib system.  Fix building for
	# emul-linux-x86-gtklibs
	if multilib_enabled ; then
		epatch "${FILESDIR}/${PN}-1.2.5-lib64.patch"
	fi
	# for chinese charater length calulation, from svn repos.
	epatch "${FILESDIR}/${PN}-r2742-r2748.patch"
}

src_install() {
	gnome2_src_install
	rm "${D}/etc/pango/pango.modules"
}

pkg_postinst() {
	if [[ "${ROOT}" == "/" ]] ; then
		einfo "Generating modules listing..."

		local PANGO_CONFDIR=

		if multilib_enabled ; then
			PANGO_CONFDIR="/etc/pango/${CHOST}"
		else
			PANGO_CONFDIR="/etc/pango"
		fi

		mkdir -p ${PANGO_CONFDIR}

		pango-querymodules > ${PANGO_CONFDIR}/pango.modules
	fi
}
