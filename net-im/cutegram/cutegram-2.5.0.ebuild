# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qmake-utils

MY_PV=${PV}-stable

DESCRIPTION="A different telegram client from Aseman team forked from Sigram by Sialan Labs. "
HOMEPAGE="http://aseman.co/en/products/cutegram/"
SRC_URI="https://github.com/Aseman-Land/Cutegram/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	>=net-misc/TelegramQML-0.8.0
	dev-qt/qtwebkit:5
	dev-qt/qtmultimedia:5
"
RDEPEND="${DEPEND}"

src_unpack(){
	unpack ${A}
	mv ${WORKDIR}/Cutegram-${MY_PV} ${S}
}

src_configure(){
	eqmake5 PREFIX="${EPREFIX}/usr"
}

src_install(){
	emake INSTALL_ROOT="${D}" install
}
