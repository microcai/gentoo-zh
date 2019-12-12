# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit qmake-utils

DESCRIPTION="Base development tool of all C++/Qt Developer work on Deepin - Core modules"
HOMEPAGE="https://github.com/linuxdeepin/dtkcore"

if [[ "${PV}" == *9999* ]] ; then
    inherit git-r3
    EGIT_REPO_URI="https://github.com/linuxdeepin/${PN}.git"
else
   	SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi
LICENSE="GPL-3"
SLOT="0/${PV}"
IUSE=""

RDEPEND=">=dev-qt/qtcore-5.5:5
		dev-qt/qtdbus
		dev-qt/qttest
		x11-libs/gsettings-qt
	    "
DEPEND="${RDEPEND}"

src_prepare() {
	LIBDIR=$(get_libdir)
	sed -i "s|/lib/|/${LIBDIR}/|g" tools/settings/settings.pro || die
	QT_SELECT=qt5 eqmake5 PREFIX=/usr LIB_INSTALL_DIR=/usr/$(get_libdir) DTK_VERSION=${PV}
	default_src_prepare
}

src_install() {
	emake INSTALL_ROOT=${D} install
}

