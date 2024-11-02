# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="GeoIP for V2Ray."
HOMEPAGE="https://github.com/v2fly/geoip"
SRC_URI="
	https://github.com/v2fly/geoip/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/blackteahamburger/gentoo-deps/releases/download/${P}/${P}-vendor.tar.xz
"

S="${WORKDIR}/geoip-${PV}"

LICENSE="CC-BY-SA-4.0 GeoLite2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="mmdb"

RDEPEND="!dev-libs/v2ray-geoip-bin"
BDEPEND="
	>=dev-lang/go-1.21
	app-arch/unzip
"

src_unpack() {
	go-module_src_unpack

	local distdir="${PORTAGE_ACTUAL_DISTDIR:-${DISTDIR}}"
	if use !mmdb; then
		if ! [ -f "${distdir}/GeoLite2-Country-CSV.zip" ]; then
			eerror "Please first download GeoLite2-Country-CSV.zip from MaxMind"
			eerror "https://dev.maxmind.com/geoip/geoip2/geolite2/"
			die "GeoLite2-Country-CSV.zip not found"
		fi
		unpack "${distdir}/GeoLite2-Country-CSV.zip"
		mv "${WORKDIR}"/GeoLite2* "${S}/geolite2" || die
	else
		if ! [ -f "${distdir}/GeoLite2-Country.mmdb" ]; then
			eerror "Please first download GeoLite2-Country.mmdb from MaxMind"
			eerror "https://dev.maxmind.com/geoip/geoip2/geolite2/"
			eerror "or with net-misc/geoipupdate"
			die "GeoLite2-Country.mmdb not found"
		fi
		mkdir "${S}/geolite2" || die
		cp "${distdir}/GeoLite2-Country.mmdb" "${S}/geolite2" || die
	fi
}

src_prepare() {
	# remove unneeded outputs
	sed -i -e '29,57d' config.json

	use mmdb && eapply "${FILESDIR}/${P}-mmdb.patch"

	default
}

src_compile() {
	ego run ./
}

src_install() {
	insinto /usr/share/geoip/
	newins output/geoip.dat v2fly.dat
}
