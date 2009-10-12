# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXft/libXft-2.1.14.ebuild,v 1.1 2009/10/12 00:07:57 remi Exp $

inherit x-modular flag-o-matic

DESCRIPTION="X.Org Xft library"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="bindist"

RDEPEND="x11-libs/libXrender
	x11-libs/libX11
	x11-libs/libXext
	x11-proto/xproto
	>=media-libs/fontconfig-2.2
	media-libs/freetype"

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
	cd "${S}"/src

	if ! use bindist; then
		# ClearType-like patches applied by ArchLinux
		epatch "${FILESDIR}"/${PN}-2.1.14-cleartype.patch
	fi
}

pkg_postinst() {
	echo
	ewarn "DO NOT report bugs to Gentoo's bugzilla"
	ewarn "See http://forums.gentoo.org/viewtopic-t-511382.html for support topic on Gentoo forums."
	echo
}
