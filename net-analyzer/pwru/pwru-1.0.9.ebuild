# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info

DESCRIPTION="eBPF-based Linux kernel networking debugger"
HOMEPAGE="https://github.com/cilium/pwru"
SRC_URI="
	https://github.com/cilium/pwru/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
"
S="${WORKDIR}/${P}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"
MINKV="5.18"
RESTRICT="strip"

BDEPEND="llvm-core/clang"
RDEPEND="!net-analyzer/pwru-bin"

pkg_pretend() {
	local CONFIG_CHECK="
		~DEBUG_INFO_BTF
		~KPROBES
		~PERF_EVENTS
		~BPF
		~BPF_SYSCALL
		~FUNCTION_TRACER
		~FPROBE
	"

	if kernel_is -lt ${MINKV//./ }; then
		ewarn "Kernel version at least ${MINKV} required"
	fi

	check_extra_config
}

src_compile() {
	case ${ARCH} in
		amd64) LIBPCAP_ARCH=x86_64-unknown-linux-gnu ;;
		arm64) LIBPCAP_ARCH=aarch64-unknown-linux-gnu ;;
		*) die "unsupported ARCH: ${ARCH}" ;;
	esac
	emake "${PN}" LIBPCAP_ARCH="${LIBPCAP_ARCH}" TARGET_GOARCH="${ARCH}" VERSION="${PV}"
}

src_install() {
	dobin "${PN}"
}
