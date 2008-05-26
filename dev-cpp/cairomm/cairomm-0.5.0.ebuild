# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/dev-cpp/cairomm/cairomm-0.5.0.ebuild,v 1.1 2006/07/07 08:11:12 palatis Exp $

inherit eutils

DESCRIPTION="C++ bindings for the Cairo vector graphics library"
HOMEPAGE="http://cairographics.org/"
SRC_URI="http://cairographics.org/releases/${P}.tar.gz"

LICENSE="|| ( LGPL-2.1 MPL-1.1 )"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="!<x11-libs/cairo-1.0"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"

src_install() {
	einstall || die "Installation failed"
	dodoc AUTHORS ChangeLog NEWS README
}
