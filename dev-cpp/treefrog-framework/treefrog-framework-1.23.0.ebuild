# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit qmake-utils

DESCRIPTION="High-speed C++ MVC Framework for Web Application"
HOMEPAGE="http://www.treefrogframework.org"
if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/treefrogframework/${PN}.git"
else
	SRC_URI="https://github.com/treefrogframework/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="BSD"
SLOT="0"
IUSE=""

RDEPEND=">=dev-qt/qtcore-5.2
		dev-qt/qtdeclarative:5
		dev-qt/qtsql:5
		dev-qt/qtxml:5
	    "
#       dev-libs/mongo-c-driver"
DEPEND="${RDEPEND}
	     "

src_configure() {
	QMAKE="$(qt5_get_bindir)"/qmake ./configure --prefix=/usr --datadir=/usr/share --libdir=/usr/$(get_libdir)
}

src_compile() {
	cd src
	emake
}

src_install() {
	cd ${S}/src
	emake INSTALL_ROOT=${D} install
}

