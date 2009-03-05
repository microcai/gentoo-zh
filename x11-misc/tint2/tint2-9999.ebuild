# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

ESVN_REPO_URI="http://tint2.googlecode.com/svn/trunk"
inherit subversion toolchain-funcs

DESCRIPTION="tint2 is a lightweight panel/taskbar based on ttm code"
HOMEPAGE="http://tint2.googlecode.com"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=dev-libs/glib-2
	x11-libs/cairo
	x11-libs/pango
	x11-libs/libX11
	x11-libs/libXinerama
	media-libs/imlib2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	subversion_src_unpack
	mv src/* .
}

src_compile() {
	emake CC="$(tc-getCC)" LDFLAGS="${LDFLAGS}" CFLAGS="${CFLAGS}" ||die
}

src_install() {
	insinto /etc/xdg
	newins tintrc01 tintrc || die "newins failed"
	dobin tint2 || die "dobin failed"

	doman doc/man/${PN}.1
	dodoc ChangeLog README tintrc* doc/tint2*
}
