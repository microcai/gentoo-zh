# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

CMAKE_MIN_VERSION="2.6"
inherit cmake-utils

DESCRIPTION="Free and open source implemention of Fetion library"
HOMEPAGE="http://code.google.com/p/ofetion"
SRC_URI="http://ofetion.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-db/sqlite:3
	dev-libs/libxml2
	dev-libs/openssl"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( AUTHORS README ChangeLog )
PATCHES=( "${FILESDIR}"/${P}-fix-version.patch )
