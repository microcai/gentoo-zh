# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular flag-o-matic

DESCRIPTION="X.Org Xft library"

KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"

IUSE="cleartype zh_TW"

RDEPEND="x11-libs/libXrender
	x11-libs/libX11
	x11-libs/libXext
	x11-proto/xproto
	media-libs/freetype
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

src_unpack()
{
	unpack ${A}
	cd ${S}
	
	#use zh_TW && epatch ${FILESDIR}/libXft-2.1.7-add-embeddedbitmap-and-gamma-option.patch
	#use zh_TW && epatch ${FILESDIR}/libXft-2.1.7-lazy-embolden.diff
	#use zh_TW && epatch ${FILESDIR}/libXft-2.1.8.2-autohint.diff

	#http://aur.archlinux.org/packages/libxft-cleartype/libxft-cleartype/libXft-2.1.10-lcd-cleartype.diff
	use cleartype && epatch "${FILESDIR}/libXft-2.1.10-lcd-cleartype.diff"
	use zh_TW && epatch ${FILESDIR}/xft-2.1.8.2-CJK-fixwidth-embeddedbitmaps-artificial_bold-20031127.patch
}
