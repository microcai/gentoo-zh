# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils

DESCRIPTION="An open source Evernote clone"
HOMEPAGE="http://nevernote.sourceforge.net/index.htm"
SRC_URI="x86?    ( mirror://sourceforge/nevernote/${P}_i386.tar.gz )
		 amd64?  ( mirror://sourceforge/nevernote/${P}_amd64.tar.gz )"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND=">=virtual/jdk-1.5
 		 media-libs/libpng:1.2"

S="${PN}"
src_install() {
	cp -rf "${S}/usr" "${D}/"
}
