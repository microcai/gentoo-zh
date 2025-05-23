# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd shell-completion

_PV="${PV/_/-}"
_PV="${_PV/alpha/alpha.}"
_PV="${_PV/beta/beta.}"
_PV="${_PV/rc/rc.}"

DESCRIPTION="The universal proxy platform."
HOMEPAGE="https://sing-box.sagernet.org/ https://github.com/SagerNet/sing-box"
SRC_URI="
	https://github.com/SagerNet/sing-box/archive/refs/tags/v${_PV}.tar.gz -> ${P}.tar.gz
	tor? ( https://github.com/gentoo-zh/gentoo-deps/releases/download/${P}/${P}-deps.tar.xz )
	!tor? ( https://github.com/gentoo-zh/gentoo-deps/releases/download/${P}/${P}-vendor.tar.xz )
"

S="${WORKDIR}/${PN}-${_PV}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~riscv"

IUSE="+quic grpc +dhcp +wireguard +ech +utls +reality +acme +clash-api v2ray-api +gvisor tor"

BDEPEND="
	ech? ( >=dev-lang/go-1.21 )
	!ech? ( >=dev-lang/go-1.20 )
"

src_compile() {
	if use quic; then _TAGS+="with_quic,"; fi
	if use grpc; then _TAGS+="with_grpc,"; fi
	if use dhcp; then _TAGS+="with_dhcp,"; fi
	if use wireguard; then _TAGS+="with_wireguard,"; fi
	if use ech; then _TAGS+="with_ech,"; fi
	if use utls; then _TAGS+="with_utls,"; fi
	if use reality; then _TAGS+="with_reality_server,"; fi
	if use acme; then _TAGS+="with_acme,"; fi
	if use clash-api; then _TAGS+="with_clash_api,"; fi
	if use v2ray-api; then _TAGS+="with_v2ray_api,"; fi
	if use gvisor; then _TAGS+="with_gvisor,"; fi
	if use tor; then _TAGS+="with_embedded_tor,"; fi

	ego build -o sing-box -trimpath -tags "${_TAGS%,}" \
		-ldflags "-s -w -X 'github.com/sagernet/sing-box/constant.Version=${PV}'" \
		./cmd/sing-box

	mkdir -v completions

	./sing-box completion bash > completions/sing-box
	./sing-box completion fish > completions/sing-box.fish
	./sing-box completion zsh > completions/_sing-box
}

src_install() {
	dobin sing-box
	insinto /etc/sing-box
	newins release/config/config.json config.json.example
	systemd_dounit release/config/sing-box{,@}.service
	dobashcomp completions/sing-box
	dofishcomp completions/sing-box.fish
	dozshcomp completions/_sing-box
}
