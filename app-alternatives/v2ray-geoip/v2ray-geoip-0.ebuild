# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ALTERNATIVES=(
	v2fly:dev-libs/v2ray-geoip-bin
	"loyalsoldier:dev-libs/v2ray-rules-dat[geoip]"
)

inherit app-alternatives

DESCRIPTION="symlink for v2ray-geoip"
KEYWORDS="~amd64 ~arm ~arm64 ~riscv ~x86"

src_install() {
	dosym -r "/usr/share/geoip/$(get_alternative).dat" /usr/share/v2ray/geoip.dat
}
