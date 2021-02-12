# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libtifiles2/libtifiles2-1.1.6-r1.ebuild,v 1.2 2014/07/15 14:37:09 jlec Exp $

EAPI=7

inherit autotools eutils git-r3

DESCRIPTION="Library for TI calculator files"
HOMEPAGE="http://lpg.ticalc.org/prj_tilp/"
SRC_URI=""

EGIT_REPO_URI="https://github.com/debrouxl/tilibs.git"

MY_PN="libtifiles"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="doc nls static-libs"

RDEPEND="
	app-arch/libarchive
	dev-libs/glib:2
	>=sci-libs/libticables2-1.3.3
	>=sci-libs/libticonv-1.1.3
	nls? ( virtual/libintl )"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

DOCS=( AUTHORS LOGO NEWS README ChangeLog docs/api.txt )

src_prepare() {
	S="${S}/${MY_PN}/trunk/"
	cd ${S}

	eautoreconf
}

src_configure() {
	econf \
		--disable-rpath \
		$(use_enable nls) \
		$(use_enable static-libs static)
}

src_install() {
	default
	use doc && dohtml docs/html/*
}
