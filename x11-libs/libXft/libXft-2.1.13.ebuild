# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXft/libXft-2.1.13.ebuild,v 1.1 2008/07/05 06:27:20 dberkholz Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular flag-o-matic

DESCRIPTION="X.Org Xft library"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"

EAPI="1"
IUSE="+newspr"

RDEPEND="x11-libs/libXrender
	x11-libs/libX11
	x11-libs/libXext
	x11-proto/xproto
	newspr? ( >=media-libs/freetype-2.3.1 )
	!newspr? ( media-libs/freetype )
	>=media-libs/fontconfig-2.2"
DEPEND="${RDEPEND}"

pkg_setup() {
	# No such function yet
	# x-modular_pkg_setup

	# (#125465) Broken with Bdirect support
	filter-flags -Wl,-Bdirect
	filter-ldflags -Bdirect
	filter-ldflags -Wl,-Bdirect
}

src_unpack() {
	unpack ${A}
	cd "${S}"/src/
	if use newspr ; then
		epatch "${FILESDIR}"/${PN}-dont_interfere_with_newspr-include-embeddedbitmap.patch.bz2 || die
	fi
}

pkg_postinst() {
	ewarn "DO NOT report bugs to Gentoo's bugzilla"
	einfo "See http://forums.gentoo.org/viewtopic-t-511382.html for support topic on Gentoo forums."
	einfo "Thank you on behalf of the Gentoo Xeffects team"
}
