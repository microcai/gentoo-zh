# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module systemd

DESCRIPTION="Another Clash Kernel, formerly Clash.Meta"
HOMEPAGE="
	https://wiki.metacubex.one/
	https://github.com/MetaCubeX/mihomo/
"
SRC_URI="
	https://github.com/MetaCubeX/mihomo/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
"
SRC_URI+="
	https://github.com/peeweep/gentoo-go-deps/releases/download/${P}/${P}-deps.tar.xz
"

DEPEND="
	acct-group/mihomo
	acct-user/mihomo
"
RDEPEND="${DEPEND}"
BDEPEND=">=dev-lang/go-1.20.4"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="+gvisor"

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
	newinitd "${FILESDIR}"/mihomo.initd mihomo
}
