# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qmake-utils

DESCRIPTION="Simple offline API documentation browser"
HOMEPAGE="http://zealdocs.org/"
SRC_URI="https://github.com/zealdocs/zeal/archive/v0.1.1.tar.gz -> ${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-qt/qtgui-5.2
>=dev-qt/qtwidgets-5.2
>=dev-qt/qtsql-5.2
"
RDEPEND="${DEPEND}"

src_configure(){
	eqmake5
}

src_install(){
	einstall INSTALL_ROOT=${D}
}
