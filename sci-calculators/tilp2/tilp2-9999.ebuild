# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/tilp2/tilp2-1.17-r1.ebuild,v 1.1 2013/07/12 16:51:56 bicatali Exp $

EAPI=5

inherit autotools eutils git-2

DESCRIPTION="Communication program for Texas Instruments calculators "
HOMEPAGE="http://lpg.ticalc.org/prj_tilp"
SRC_URI=""

EGIT_REPO_URI="https://github.com/debrouxl/tilp_and_gfm.git"

MY_PN="tilp"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="nls threads xinerama"

RDEPEND="
	dev-libs/glib:2
	gnome-base/libglade:2.0
	x11-libs/gtk+:2
	=sci-libs/libticalcs2-9999
	=sci-libs/libticables2-9999
	=sci-libs/libtifiles2-9999
	=sci-libs/libticonv-9999
	nls? ( virtual/libintl )
	xinerama? ( x11-libs/libXinerama )"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )
	xinerama? ( x11-proto/xineramaproto )"

src_prepare() {
	S="${S}/${MY_PN}/trunk/"
	cd ${S}
	eautoreconf
}

src_configure() {
	# kde seems to be kde3 only
	econf \
		--disable-rpath \
		--without-kde \
		$(use_enable nls) \
		$(use_enable threads threading) \
		$(use_with xinerama)
}
