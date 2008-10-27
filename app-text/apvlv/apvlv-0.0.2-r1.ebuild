# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="a PDF Viewer whose behaviour like Vi."
HOMEPAGE="http://code.google.com/p/apvlv/"
SRC_URI="http://apvlv.googlecode.com/files/${P}-bug-fix-1.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RESTICT="primaryuri"

RDEPEND=">=x11-libs/gtk+-2.6
	>=app-text/poppler-0.5.4
	>=app-text/poppler-bindings-0.5.4[gtk]"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9.0"

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS NEWS README THANKS
}
