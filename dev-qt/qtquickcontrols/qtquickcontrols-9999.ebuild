# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

EGIT_REPO_URI="git://gitorious.org/qt/qtquickcontrols.git"
EGIT_BRANCH="qt4"

inherit qt4-r2 git-2

DESCRIPTION="Qt Quick Controls (Former Qt Desktop Components)"
HOMEPAGE="http://qt-project.org/wiki/QtDesktopComponents"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS=""
IUSE="debug"

DEPEND=">=dev-qt/qtdeclarative-4.7.4
"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_configure() {
	eqmake4 desktop.pro PREFIX="/usr"
}
