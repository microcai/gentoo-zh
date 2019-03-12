# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit qmake-utils

DESCRIPTION="Extra plugins for dde-file-manager"
HOMEPAGE="https://github.com/linuxdeepin/dde-file-manager-integration"
if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/linuxdeepin/${PN}.git"
else
	SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dde-base/dde-file-manager
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtnetwork:5
		dev-qt/qtwebkit:5
		dev-qt/qtwidgets:5
		media-libs/fontconfig
		"

DEPEND="${RDEPEND}
		virtual/pkgconfig
	    "

src_prepare() {
	LIBDIR=$(get_libdir)

	sed -i "s|lib/\$\${QMAKE_HOST.arch}-linux-gnu|${LIBDIR}|g" webview/webview.pro
	sed -i "s|lib/\$\${QMAKE_HOST.arch}-linux-gnu|${LIBDIR}|g" nutstore-dfm-plugin/nutstore-dfm-plugin.pro
	sed -i "s|lib/\$\${QMAKE_HOST.arch}-linux-gnu|${LIBDIR}|g" clipboard-files/clipboard-files.pro

	export QT_SELECT=qt5
	eqmake5
}

src_install() {
	emake INSTALL_ROOT=${D} install
}

