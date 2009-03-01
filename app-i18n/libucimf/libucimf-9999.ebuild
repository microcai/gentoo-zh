# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

ESVN_REPO_URI="https://ucimf.svn.sourceforge.net/svnroot/ucimf/libucimf"
inherit autotools subversion

DESCRIPTION="Unicode Console InputMethod Framework"
HOMEPAGE="http://ucimf.sourceforge.net/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug"

# FIXME:
# sys-libs/zlib
DEPEND="media-libs/freetype:2"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf $(use_enable debug)
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS ChangeLog README TODO
}
