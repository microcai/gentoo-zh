# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_MAKEFILE_GENERATOR="emake"
inherit cmake

if [[ ${PV} == 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cutefishos/terminal.git"
	EGIT_CHECKOUT_DIR=cutefish-terminal-${PV}
	KEYWORDS=""
else
	EGIT_COMMIT="012ac1282abaa09713c04147831a4bd197d43364"
	SRC_URI="https://github.com/cutefishos/terminal/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~riscv"
	S="${WORKDIR}/terminal-${EGIT_COMMIT}"
fi

DESCRIPTION="A terminal emulator for Cutefish"
HOMEPAGE="https://github.com/cutefishos/terminal"
LICENSE="GPL-3"
SLOT="0"
IUSE=""
RDEPEND="
	sys-libs/fishui
"
DEPEND="
	dev-qt/qtcore
	dev-qt/qtgui
	dev-qt/qtquickcontrols2
	dev-qt/qtdbus
	dev-qt/linguist-tools
"
BDEPEND="${DEPEND}"

src_configure(){
	mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="/usr"
	)
	cmake_src_configure
}
