# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#EAPI="2"

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular flag-o-matic

DESCRIPTION="X.Org Xft library"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"

IUSE="cleartype ubuntu"

RDEPEND="x11-libs/libXrender
	x11-libs/libX11
	x11-libs/libXext
	x11-proto/xproto
	>=media-libs/fontconfig-2.2
	media-libs/freetype"

#	>=media-libs/fontconfig-2.2[ubuntu=]
#	media-libs/freetype[ubuntu=,cleartype=]

#    ubuntu? ( media-libs/freetype[-cleartype] )
#    cleartype? ( media-libs/freetype[-ubuntu] )



DEPEND="${RDEPEND}"

pkg_setup() {
	# No such function yet
	# x-modular_pkg_setup

	# (#125465) Broken with Bdirect support
	filter-flags -Wl,-Bdirect
	filter-ldflags -Bdirect
	filter-ldflags -Wl,-Bdirect

	if use cleartype && use ubuntu; then
		eerror "The cleartype and ubuntu useflags are mutually exclusive,"
		eerror "you must disable one of them."
		die "Either disable the cleartype or the ubuntu useflag."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"/src

	if use cleartype; then
		# ClearType-like patches applied by ArchLinux
		epatch "${FILESDIR}"/${PN}-2.1.10-lcd-cleartype.diff
	elif use ubuntu; then
		# LCD filtering patches applied by ubuntu
		epatch "${FILESDIR}"/${PN}-ubuntu-002_embeddedbitmap_property.patch
		epatch "${FILESDIR}"/${PN}-ubuntu-003_lcd-filter-3.patch
	fi
}

pkg_postinst() {
	echo
	ewarn "DO NOT report bugs to Gentoo's bugzilla"
	ewarn "See http://forums.gentoo.org/viewtopic-t-511382.html for support topic on Gentoo forums."
	echo
}
