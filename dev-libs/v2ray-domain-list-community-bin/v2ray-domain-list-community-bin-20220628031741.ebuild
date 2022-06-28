# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Community managed domain list for V2Ray."
HOMEPAGE="https://github.com/v2fly/domain-list-community"
SRC_URI="https://github.com/v2fly/domain-list-community/releases/download/${PV}/dlc.dat -> ${P}.dat"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
RESTRICT="mirror"

DEPEND=""
RDEPEND="${DEPEND}
	!dev-libs/v2ray-domain-list-community
"
BDEPEND=""

src_install() {
	insinto /usr/share/v2ray
	newins "${DISTDIR}/${P}.dat" geosite.dat
}
