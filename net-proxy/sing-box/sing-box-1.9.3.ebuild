# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd

_PV="${PV/_/-}"
_PV="${_PV/alpha/alpha.}"
_PV="${_PV/beta/beta.}"
_PV="${_PV/rc/rc.}"

DESCRIPTION="The universal proxy platform."
HOMEPAGE="https://sing-box.sagernet.org/ https://github.com/SagerNet/sing-box"
SRC_URI="https://github.com/SagerNet/sing-box/archive/refs/tags/v${_PV}.tar.gz -> ${P}.tar.gz
	https://github.com/Puqns67/gentoo-deps/releases/download/${P}/${P}-vendor.tar.xz"

S="${WORKDIR}/${PN}-${_PV}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~riscv"

IUSE="+quic grpc +dhcp +wireguard +ech +utls +reality +acme +clash-api v2ray-api +gvisor tor"

RESTRICT="mirror"

src_compile() {
	TAGS=""
	if use quic; then TAGS+="with_quic,"; fi
	if use grpc; then TAGS+="with_grpc,"; fi
	if use dhcp; then TAGS+="with_dhcp,"; fi
	if use wireguard; then TAGS+="with_wireguard,"; fi
	if use ech; then TAGS+="with_ech,"; fi
	if use utls; then TAGS+="with_utls,"; fi
	if use reality; then TAGS+="with_reality_server,"; fi
	if use acme; then TAGS+="with_acme,"; fi
	if use clash-api; then TAGS+="with_clash_api,"; fi
	if use v2ray-api; then TAGS+="with_v2ray_api,"; fi
	if use gvisor; then TAGS+="with_gvisor,"; fi
	if use tor; then TAGS+="with_embedded_tor,"; fi
	TAGS="${TAGS%,}"

	ego build -o sing-box -trimpath -tags "${TAGS}" \
		-ldflags "-s -w -X 'github.com/sagernet/sing-box/constant.Version=${PV}' -buildid=" \
		./cmd/sing-box
}

src_install() {
	dobin sing-box
	insinto /etc/sing-box
	newins release/config/config.json config.json.example
	systemd_dounit release/config/sing-box{,@}.service
}
