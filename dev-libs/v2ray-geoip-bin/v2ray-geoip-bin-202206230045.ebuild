# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="GeoIP for V2Ray."
HOMEPAGE="https://github.com/v2fly/geoip"
SRC_URI="https://github.com/v2fly/geoip/releases/download/${PV}/geoip.dat -> ${P}.dat"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
S="${WORKDIR}"

LICENSE="CC-BY-SA-4.0"
SLOT="0"
RESTRICT="mirror"

src_install() {
	insinto /usr/share/v2ray
	newins "${DISTDIR}/${P}.dat" geoip.dat
}
