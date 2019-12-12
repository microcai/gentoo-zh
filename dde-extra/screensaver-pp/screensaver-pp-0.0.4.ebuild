# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit qmake-utils

DESCRIPTION="Bubbles ScreenSaver for Deepin Screensaver"
HOMEPAGE="https://github.com/zccrs/screensaver-pp"
SRC_URI="https://github.com/zccrs/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-qt/qtdeclarative:5
		"
RDEPEND="${DEPEND}
		"

src_prepare() {
	eapply_user
	LIBDIR=$(get_libdir)
	sed -i "s|lib/|${LIBDIR}/|g" ${PN}.pro
	QT_SELECT=qt5 eqmake5
}

src_install() {
	emake INSTALL_ROOT=${D} install
}
