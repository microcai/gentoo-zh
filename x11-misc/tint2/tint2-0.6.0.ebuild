# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="tint2 is a lightweight panel/taskbar based on ttm code"
HOMEPAGE="http://tint2.googlecode.com"
SRC_URI="http://tint2.googlecode.com/files/${P/2}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2
	x11-libs/cairo
	x11-libs/pango
	x11-libs/libX11
	x11-libs/libXinerama
	media-libs/imlib2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${PN/2}

src_unpack() {
	unpack ${A}

	cd "${S}" && mv src/* .
	sed -i \
		-e "/strip/d" Makefile \
		|| die "sed failed"
}

src_install() {
	insinto /etc/xdg
	newins tintrc1 tintrc || die "newins failed"
	newbin tint tint2 || die "newbin failed"

	dodoc ChangeLog README tintrc[1-4]
	dodoc doc/*
}
