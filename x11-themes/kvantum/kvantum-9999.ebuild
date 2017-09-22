# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

if [[ -z ${PV%%*9999} ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/tsujan/${PN}.git"
else
	inherit vcs-snapshot
	MY_PV="49a8ef0"
	[[ -n ${PV%%*_p*} ]] && MY_PV="V${PV}"
	SRC_URI="https://github.com/tsujan/Kvantum/archive/V0.10.4.tar.gz -> 
kvantum-0.10.4.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi
inherit qmake-utils

DESCRIPTION="An SVG-based theme engine for Qt"
HOMEPAGE="https://github.com/tsujan/${PN}"

LICENSE="GPL-3"
SLOT="0"
IUSE="qt4 qt5"
REQUIRED_USE="|| ( qt4 qt5 )"

DEPEND="
	qt4? (
		dev-qt/qtgui:4
		dev-qt/qtsvg:4
	)
	qt5? (
		dev-qt/qtgui:5
		dev-qt/qtsvg:5
		dev-qt/qtx11extras:5
	)
	x11-libs/libXext
"
RDEPEND="${DEPEND}"

src_configure() {
	mkdir -p $(usev qt4) $(usev qt5)
	local _p="${S}/${PN^}/${PN}.pro"
	if use qt4; then
		cd "${S}"/qt4
		eqmake4 "${_p}"
	fi
	if use qt5 ; then
		cd "${S}"/qt5
		eqmake5 "${_p}"
	fi
}

src_compile() {
	use qt4 && emake -C qt4
	use qt5 && emake -C qt5
}

src_install() {
	declare -x INSTALL_ROOT="${D}"
	use qt4 && emake -C qt4 install
	use qt5 && emake -C qt5 install
}
