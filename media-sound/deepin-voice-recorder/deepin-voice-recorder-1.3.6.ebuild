# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit qmake-utils eutils

DESCRIPTION="Deepin Voice Recorder"
HOMEPAGE="https://github.com/linuxdeepin/deepin-voice-recorder/"

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/linuxdeepin/${PN}.git"
else
	SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtmultimedia:5
	dev-qt/qtwidgets:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork
	virtual/ffmpeg
	"

DEPEND="${RDEPEND}
		>=dde-base/dtkwidget-2.0.2:=
		"

src_prepare() {
	QT_SELECT=qt5 eqmake5 ${PN}.pro
}

src_install() {
	emake INSTALL_ROOT=${D} install
}
