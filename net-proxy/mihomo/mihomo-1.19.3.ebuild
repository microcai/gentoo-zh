# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module systemd fcaps

DESCRIPTION="Another Clash Kernel, formerly Clash.Meta"
HOMEPAGE="
	https://wiki.metacubex.one/
	https://github.com/MetaCubeX/mihomo/
"
SRC_URI="
	https://github.com/MetaCubeX/mihomo/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/gentoo-zh/gentoo-deps/releases/download/${P}/${P}-vendor.tar.xz
"

DEPEND="
	acct-group/mihomo
	acct-user/mihomo
"
RDEPEND="
	${DEPEND}
	systemd? (
		sys-apps/systemd
	)
	!systemd? (
		tun? (
			sys-apps/openrc[caps(+)]
		)
		!tun? (
			sys-apps/openrc
		)
	)
"
BDEPEND=">=dev-lang/go-1.20.4"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~loong"
IUSE="+gvisor systemd +tun"

FILECAPS=(
	cap_net_admin,cap_net_bind_service=+ep /usr/bin/mihomo
)

src_compile() {
	local BUILDTIME=$(LC_ALL=C date -u || die)
	local MY_TAGS
	if use gvisor; then
		MY_TAGS="with_gvisor"
	fi
	ego build -tags "${MY_TAGS}" -trimpath -ldflags "
		-linkmode external -extldflags \"${LDFLAGS}\" \
		-X \"github.com/metacubex/mihomo/constant.Version=${PV}\" \
		-X \"github.com/metacubex/mihomo/constant.BuildTime=${BUILDTIME}\" \
		-w -s -buildid=" \
		-o bin/mihomo
}

src_install() {
	dobin bin/mihomo
	dosym -r "/usr/bin/mihomo" "/usr/bin/clash-meta"
	systemd_dounit "${FILESDIR}/mihomo.service"
	systemd_newunit "${FILESDIR}/mihomo_at.service" mihomo@.service
	newinitd "${FILESDIR}"/mihomo.initd mihomo
}
