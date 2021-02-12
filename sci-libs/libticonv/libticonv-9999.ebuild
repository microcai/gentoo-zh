# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libticonv/libticonv-1.1.4.ebuild,v 1.1 2013/07/09 16:43:59 bicatali Exp $

EAPI=7

inherit autotools eutils git-r3

DESCRIPTION="Charset conversion library for TI calculators"
HOMEPAGE="http://lpg.ticalc.org/prj_tilp/"
SRC_URI=""

EGIT_REPO_URI="https://github.com/debrouxl/tilibs.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="doc iconv static-libs"

RDEPEND="dev-libs/glib:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( AUTHORS LOGO NEWS README ChangeLog docs/api.txt )

src_prepare() {
	S="${S}/${PN}/trunk/"
	cd ${S}

	eautoreconf
}

src_configure() {
	econf \
		$(use_enable iconv) \
		$(use_enable static-libs static)
}

src_install() {
	default
	if use doc; then
		dohtml docs/html/*
		docinto charsets
		dohtml docs/charsets/*
	fi
}
