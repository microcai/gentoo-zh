# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="GeoIP for V2Ray."
HOMEPAGE="https://github.com/v2fly/geoip https://www.maxmind.com"
if [[ ${PV} == *9999 ]]; then
	PROPERTIES="live"
	SRC_URI=
else
	SRC_URI="https://github.com/v2fly/geoip/releases/download/${PV#*_p}/geoip.dat -> ${P}.dat"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi
S="${WORKDIR}"

LICENSE="CC-BY-SA-4.0"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
	!<net-proxy/v2ray-4.38.3
	!<net-proxy/v2ray-core-4.38.3
"
BDEPEND=""

src_unpack() {
	if [[ ${PV} == *9999 ]]; then
		wget "https://github.com/v2fly/geoip/releases/latest/download/geoip.dat" || die
		wget "https://github.com/v2fly/geoip/releases/latest/download/geoip.dat.sha256sum" || die
		sha256sum -c geoip.dat.sha256sum || die "check sha256sum for 'geoip.dat' failed"
	else
		cp ${DISTDIR%/}/${P}.dat geoip.dat || die
	fi
}

src_install() {
	insinto /usr/share/v2ray
	doins geoip.dat
}
