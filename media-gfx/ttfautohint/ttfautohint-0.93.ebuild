# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit qt4-r2

DESCRIPTION="automated hinting process for web fonts"
HOMEPAGE="http://www.freetype.org/ttfautohint/"
SRC_URI="mirror://sourceforge/freetype/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+qt"

DEPEND=">=media-libs/freetype-2.4.10
	qt? ( >=dev-qt/qtgui-4.8 )
	"
RDEPEND="${DEPEND}"

src_prepare(){

	epatch "${FILESDIR}/${P}-fix.patch"

}

src_configure(){
	econf $(use_with qt)
}
