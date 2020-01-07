# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit qmake-utils versionator


if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/robert7/${PN}2.git"
else
	SRC_URI="https://github.com/robert7/${PN}2/archive/v${PV}.tar.gz -> ${PN}2-${PV}.tar.gz"
	S="${WORKDIR}/${PN}2-${PV}"
fi

SLOT="2"
DESCRIPTION="Nixnote - Evernote desktop client for Linux"
HOMEPAGE="https://github.com/robert7/nixnote2"

LICENSE="GPL-2"
[[ ${PV} == *9999* ]] || KEYWORDS="~amd64 ~x86"
IUSE="hunspell"

DEPEND="dev-libs/boost
		net-misc/curl
		app-text/poppler[qt5]
		dev-qt/qtwebkit:5
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtsql:5
		dev-qt/qtxml:5
		dev-qt/qtnetwork:5
		dev-qt/qtwidgets:5
		dev-qt/qtprintsupport:5
		dev-qt/qtdbus:5
		dev-qt/qtdeclarative:5
		dev-qt/linguist-tools:5
		"
RDEPEND="${DEPEND}
		app-text/tidy-html5
		hunspell? ( app-text/hunspell )
		"

src_prepare() {
	sed -i "s|tidy\/||g" src/main.cpp src/html/enmlformatter.cpp || die

	default_src_prepare
}

src_configure() {
	eqmake5 CONFIG+=debug PREFIX=/usr nixnote2.pro
}

src_install() {
	emake INSTALL_ROOT=${D} install
}
