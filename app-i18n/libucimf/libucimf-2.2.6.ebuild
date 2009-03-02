# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="2"

inherit eutils

DESCRIPTION="Unicode Console InputMethod Framework"
HOMEPAGE="http://ucimf.googlecode.com"
SRC_URI="${HOMEPAGE}/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

# FIXME: sys-libs/zlib
DEPEND="media-libs/freetype:2"
RDEPEND="${DEPEND}"

pkg_setup() {
	# Make sure utmp group exists, as it's used in install-exec-hook.
	enewgroup utmp 406
}

src_configure() {
	econf $(use_enable debug)
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS ChangeLog README TODO
}
