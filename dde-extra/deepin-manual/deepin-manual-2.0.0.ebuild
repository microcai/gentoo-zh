# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils

DESCRIPTION="Deepin User Manual"
HOMEPAGE="https://github.com/linuxdeepin/deepin-manual"
if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/linuxdeepin/${PN}.git"
	EGIT_BRANCH="qcef"
else
	SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3+"
SLOT="2"
IUSE=""

DEPEND="dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
		dev-qt/linguist-tools:5
		dev-qt/qcef
		dde-base/dtkwidget:=
		virtual/pkgconfig
	    "

src_configure() {
	local mycmakeargs=(
		-DDMAN_MANUAL_DIR=/usr/share/dman
		-DDMAN_RESOURCE_DIR=/usr/share/dman
	)

	cmake-utils_src_configure
}
