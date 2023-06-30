# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module systemd

DESCRIPTION="Another Clash Kernel."
HOMEPAGE="https://github.com/MetaCubeX/Clash.Meta"

SRC_URI="
	https://github.com/MetaCubeX/Clash.Meta/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/st0nie/gentoo-go-deps/releases/download/${P}/${P}-deps.tar.xz
"

RESTRICT="mirror"
DEPEND="
	acct-user/clash-meta
	acct-group/clash-meta
	>=dev-lang/go-1.20.4
"
RDEPEND="${DEPEND}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
S="${WORKDIR}/Clash.Meta-${PV}"
IUSE="+gvisor lwip"

src_compile() {
	local BUILDTIME=$(LC_ALL=C date -u || die)
	local MY_TAGS
	if use gvisor; then
		MY_TAGS="with_gvisor"
	fi
	if use lwip; then
		MY_TAGS+=" with_lwip"
	fi
	ego build \
		-ldflags "-linkmode external -extldflags \"${LDFLAGS}\" \
	-X \"github.com/Dreamacro/clash/constant.Version=${PV}\" \
	-X \"github.com/Dreamacro/clash/constant.BuildTime=${BUILDTIME}\" \
	" \
		-tags "$MY_TAGS" -o "${P}"
}

src_install() {
	newbin "${P}" "${PN}"
	systemd_dounit "${FILESDIR}/Clash-Meta.service"
	newinitd "${FILESDIR}"/clash-meta.initd clash-meta
}
