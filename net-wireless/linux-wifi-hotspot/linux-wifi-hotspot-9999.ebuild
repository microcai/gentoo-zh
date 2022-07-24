# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
LICENSE=BSD
DESCRIPTION="Linux Wifi Hotspot"
HOMEPAGE="https://github.com/lakinduakash/linux-wifi-hotspot"
SLOT="0"
# inherit toolchain-funcs eutils

DEPEND="media-gfx/qrencode
        net-wireless/iw
	    net-wireless/hostapd
       "
RDEPEND="${DEPEND}"
if [ "$PV" == "9999" ]; then
    inherit git-r3
	EGIT_REPO_URI="https://github.com/lakinduakash/linux-wifi-hotspot.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/lakinduakash/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

src_install() {
	emake DESTDIR="${D}" install
}
