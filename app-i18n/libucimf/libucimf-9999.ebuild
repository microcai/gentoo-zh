# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="2"

ESVN_REPO_URI="http://ucimf.googlecode.com/svn/${PN}"
inherit autotools eutils subversion

DESCRIPTION="Unicode Console InputMethod Framework"
HOMEPAGE="http://ucimf.googlecode.com"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug"

# FIXME: sys-libs/zlib
DEPEND="media-libs/freetype:2"
RDEPEND="${DEPEND}"

pkg_setup() {
	# Make sure utmp group exists, as it's used in install-exec-hook.
	enewgroup utmp 406
}

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
