# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit qmake-utils eutils

DESCRIPTION="Deepin System Monitor"
HOMEPAGE="https://github.com/manateelazycat/deepin-system-monitor/"

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/linuxdeepin/${PN}.git"
else
	SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

	KEYWORDS="~amd64 ~x86"
LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="sys-process/procps
	dev-qt/qtcore:5
	dev-qt/qtwidgets:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtdbus:5
	dev-qt/qtx11extras:5
	sys-libs/libcap
	"

DEPEND="${RDEPEND}
		net-analyzer/libnethogs
		>=dde-base/deepin-tool-kit-0.2.2
	    "

src_prepare() {
	sed -i "s|/usr/local/lib/libnethogs.so|-lnethogs|g" ${PN}.pro
	eqmake5 ${PN}.pro
}

src_install() {
	dobin ${PN}
	doicon -s scalable image/${PN}.svg
	domenu debian/${PN}.desktop
#	emake INSTALL_ROOT=${D} install
}

pkg_postinst() {
	setcap cap_kill,cap_net_raw,cap_dac_read_search+ep /usr/bin/${PN}
}
