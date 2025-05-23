# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ALTERNATIVES=(
	v2fly:virtual/v2ray-domain-list-community
	"loyalsoldier:dev-libs/v2ray-rules-dat-bin[geosite]"
)

inherit app-alternatives

DESCRIPTION="symlink for v2ray-geosite"
KEYWORDS="~amd64 ~arm ~arm64 ~loong ~riscv ~x86"

src_install() {
	dosym -r "/usr/share/geosite/$(get_alternative).dat" /usr/share/v2ray/geosite.dat
}
