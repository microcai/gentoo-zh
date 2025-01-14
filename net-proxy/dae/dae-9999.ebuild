# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic linux-info git-r3 go-module systemd shell-completion

DESCRIPTION="A lightweight and high-performance transparent proxy solution based on eBPF"
HOMEPAGE="https://github.com/daeuniverse/dae"

LICENSE="AGPL-3"
SLOT="0"
MINKV="5.8"

EGIT_REPO_URI="https://github.com/daeuniverse/dae.git"

DEPEND="
	app-alternatives/v2ray-geoip
	app-alternatives/v2ray-geosite
"
RDEPEND="$DEPEND"
BDEPEND="llvm-core/clang"

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

src_prepare() {
	# Prevent conflicting with the user's flags
	# https://devmanual.gentoo.org/ebuild-writing/common-mistakes/#-werror-compiler-flag-not-removed
	sed -i -e 's/-Werror//' "${S}/Makefile" || die 'Failed to remove -Werror via sed'

	default
}

src_compile() {
	# for dae's ebpf target
	# gentoo-zh#3720
	filter-flags "-march=*" "-mtune=*"
	append-cflags "-fno-stack-protector"

	local GIT_VER=$(git describe --tags --long | sed 's/^v//;s/\([^-]*-g\)/r\1/;s/-\([^-]*\)-\([^-]*\)$/.\1.\2/;s/-//')
	emake VERSION="${GIT_VER}" GOFLAGS="-buildvcs=false"
}

src_install() {
	dobin dae

	systemd_dounit install/dae.service
	newinitd "${FILESDIR}"/dae.initd dae

	keepdir /etc/dae/
	insinto /usr/share/dae
	newins example.dae config.dae.example

	newbashcomp install/shell-completion/dae.bash dae
	newfishcomp install/shell-completion/dae.fish dae.fish
	newzshcomp install/shell-completion/dae.zsh _dae

	dosym -r "/usr/share/v2ray/geosite.dat" /usr/share/dae/geosite.dat
	dosym -r "/usr/share/v2ray/geoip.dat" /usr/share/dae/geoip.dat
}
