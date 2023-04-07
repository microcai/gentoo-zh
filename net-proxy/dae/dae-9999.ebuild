# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info git-r3 go-module systemd

DESCRIPTION="A lightweight and high-performance transparent proxy solution based on eBPF"
HOMEPAGE="https://github.com/daeuniverse/dae"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS=""
MINKV="5.8"

EGIT_REPO_URI="https://github.com/daeuniverse/dae.git"

DEPEND="
	dev-libs/v2ray-domain-list-community-bin
	dev-libs/v2ray-geoip-bin
"
RDEPEND="$DEPEND"
BDEPEND="sys-devel/clang"

pkg_pretend() {
	local CONFIG_CHECK="~DEBUG_INFO_BTF ~NET_CLS_ACT ~NET_SCH_INGRESS ~NET_INGRESS ~NET_EGRESS"

	if kernel_is -lt ${MINKV//./ }; then
		ewarn "Kernel version at least ${MINKV} required"
	fi

	check_extra_config
}

src_unpack() {
	git-r3_src_unpack
	cd "${P}" || die
	ego mod download -modcacherw
}

src_compile() {
	emake GOFLAGS="-buildvcs=false" CC=clang CFLAGS="-fno-stack-protector"
}

src_install() {
	dobin dae
	systemd_dounit install/dae.service
	insinto /etc/dae
	newins example.dae config.dae.example
	newins install/empty.dae config.dae
	dosym -r "/usr/share/v2ray/geosite.dat" /usr/share/dae/geosite.dat
	dosym -r "/usr/share/v2ray/geoip.dat" /usr/share/dae/geoip.dat
}
