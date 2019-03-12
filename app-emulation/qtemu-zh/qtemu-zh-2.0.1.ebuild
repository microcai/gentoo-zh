# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit git-2 eutils cmake-utils

DESCRIPTION="A graphical user interface for QEMU written in Qt4"
HOMEPAGE="https://github.com/cnobelw/qtemu-zh"
EGIT_REPO_URI="https://github.com/cnobelw/qtemu-zh.git"

LICENSE="GPL-2 LGPL-2.1 CC-BY-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-qt/qtcore:4
	dev-qt/qtgui:4
	net-libs/libvncserver"
RDEPEND="${DEPEND}
	app-emulation/qemu"

DOCS=( CHANGELOG README )

src_install() {
	cmake-utils_src_install
	# doicon "${S}/images/${PN}.ico"
	# make_desktop_entry "qtemu" "QtEmu" "${PN}.ico" "Qt;Utility;Emulator"
}
