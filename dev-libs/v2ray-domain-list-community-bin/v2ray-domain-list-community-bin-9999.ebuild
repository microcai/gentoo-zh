# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Community managed domain list for V2Ray."
HOMEPAGE="https://github.com/v2fly/domain-list-community"
if [[ ${PV} == *9999 ]]; then
	PROPERTIES="live"
	SRC_URI=
else
	SRC_URI="https://github.com/v2fly/domain-list-community/releases/download/${PV#*_p}/dlc.dat.xz -> ${P}.dat.xz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
	!dev-libs/v2ray-domain-list-community
	!<net-proxy/v2ray-4.38.3
"
BDEPEND=""

src_unpack() {
	if [[ ${PV} == *9999 ]]; then
		wget "https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.dat" || die
		wget "https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.dat.sha256sum" || die
		sha256sum -c dlc.dat.sha256sum || die "check sha256sum for 'dlc.dat' failed"
	else
		default
		mv ${P}.dat dlc.dat || die
	fi
}

src_install() {
	insinto /usr/share/v2ray
	newins dlc.dat geosite.dat
}
