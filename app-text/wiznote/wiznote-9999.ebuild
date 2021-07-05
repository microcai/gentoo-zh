# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/WizTeam/WizQTClient.git"
	EGIT_BRANCH="${EGIT_MASTER}"
	KEYWORDS=""
	WIZNOTE_SRC_URI=""
	WIZNOTE_ECLASS="git-r3"
else
	WIZNOTE_SRC_URI="https://github.com/WizTeam/WizQTClient/archive/v${PV}.tar.gz -> ${P}.tar.gz
		https://patch-diff.githubusercontent.com/raw/WizTeam/WizQTClient/pull/619.patch -> qt5.15.patch "
	PATCHES=( "${DISTDIR}/qt5.15.patch" )
	RESTRICT="mirror"
	WIZNOTE_ECLASS="vcs-snapshot"
	KEYWORDS="~amd64"
	SRC_URI=""
fi

inherit ${WIZNOTE_ECLASS} cmake

DESCRIPTION="cross-platform cloud based note-taking client"
HOMEPAGE="http://www.wiz.cn/index.html"
SRC_URI="${WIZNOTE_SRC_URI}"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwebkit:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
	dev-qt/qtwebsockets:5
	>=dev-qt/qtwebengine-5.7[widgets]"
DEPEND="${RDEPEND}"
