# Copyright 199f9-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module systemd

DESCRIPTION="Another Clash Kernel."
HOMEPAGE="https://github.com/MetaCubeX/Clash.Meta"

SRC_URI="
	https://github.com/MetaCubeX/Clash.Meta/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/st0nie/gentoo-go-dep/releases/download/${PN}/${P}-deps.tar.xz
"

RESTRICT="mirror"
DEPEND="
	acct-user/clash-meta
	acct-group/clash-meta
"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
S="${WORKDIR}/Clash.Meta-${PV}"

src_compile() {
	local BUILDTIME=$(date -u)
	ego build \
	-ldflags "-linkmode external -extldflags \"${LDFLAGS}\" \
	-X \"github.com/Dreamacro/clash/constant.Version=${PV}\" \
	-X \"github.com/Dreamacro/clash/constant.BuildTime=${BUILDTIME}\" \
	" \
	-tags with_gvisor -o ${P}
}

src_install() {
	newbin ${P} ${PN}
	systemd_dounit "${FILESDIR}/Clash-Meta.service"
}
