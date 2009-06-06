# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

MY_P=${P/_/-}
DESCRIPTION="tint2 is a lightweight panel/taskbar based on ttm code"
HOMEPAGE="http://tint2.googlecode.com"
SRC_URI="http://tint2.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-libs/glib:2
	x11-libs/cairo
	x11-libs/pango
	x11-libs/libX11
	x11-libs/libXinerama
	media-libs/imlib2"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xineramaproto
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_prepare() {
	mv src/* .
	sed -i \
		-e 's/^\(install: install-\)\(strip\)$/\1no\2/' \
		-e 's/\.\./\./g' \
		Makefile || die "failed sed Makefile"
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"

	dodoc ChangeLog README tintrc0[2-7]
	dodoc doc/*
}
