# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info go-module systemd

_MY_PV=${PV/_rc/rc}

DESCRIPTION="A lightweight and high-performance transparent proxy solution based on eBPF"
HOMEPAGE="https://github.com/daeuniverse/dae"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~riscv"
MINKV="5.8"
SRC_URI="
	https://github.com/daeuniverse/dae/releases/download/v${_MY_PV}/dae-full-src.zip -> ${P}.zip
"
RESTRICT="mirror"

DEPEND="
	app-alternatives/v2ray-geoip
	app-alternatives/v2ray-geosite
"
RDEPEND="$DEPEND"
BDEPEND="sys-devel/clang"

S=${WORKDIR}

pkg_pretend() {
	local CONFIG_CHECK="
		~BPF
		~BPF_SYSCALL
		~BPF_JIT
		~CGROUPS
		~KPROBES
		~NET_INGRESS
		~NET_EGRESS
		~NET_SCH_INGRESS
		~NET_CLS_BPF
		~NET_CLS_ACT
		~BPF_STREAM_PARSER
		~DEBUG_INFO
		~DEBUG_INFO_BTF
		~KPROBE_EVENTS
		~BPF_EVENTS
	"

	if kernel_is -lt ${MINKV//./ }; then
		ewarn "Kernel version at least ${MINKV} required"
	fi

	check_extra_config
}

src_compile() {
	emake VERSION="${PV}" GOFLAGS="-buildvcs=false" CC=clang CFLAGS="$CFLAGS -fno-stack-protector"
}

src_install() {
	dobin dae
	systemd_dounit install/dae.service
	newinitd "${FILESDIR}"/dae.initd dae
	insinto /etc/dae
	newins example.dae config.dae.example
	newins install/empty.dae config.dae
	dosym -r "/usr/share/v2ray/geosite.dat" /usr/share/dae/geosite.dat
	dosym -r "/usr/share/v2ray/geoip.dat" /usr/share/dae/geoip.dat
}
