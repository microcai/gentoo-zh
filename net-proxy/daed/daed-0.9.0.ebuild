# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic systemd

DESCRIPTION="A Modern Dashboard For dae"
HOMEPAGE="https://github.com/daeuniverse/daed"
SRC_URI="
	https://github.com/daeuniverse/daed/releases/download/v${PV/_rc/rc}/daed-full-src.zip -> ${P}.zip
	webui? ( https://github.com/daeuniverse/daed/releases/download/v${PV/_rc/rc}/web.zip -> ${P}-web.zip )
"
# EGIT_REPO_URI="https://github.com/daeuniverse/daed.git"

S="${WORKDIR}"
LICENSE="MIT AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	app-alternatives/v2ray-geoip
	app-alternatives/v2ray-geosite
"
RDEPEND="${DEPEND}"
BDEPEND="
	llvm-core/clang
	app-arch/unzip
	>=dev-lang/go-1.22
"
IUSE="+webui"
RESTRICT="strip"

src_prepare() {
	# Prevent conflicting with the user's flags
	sed -i -e 's/-Werror//' wing/dae-core/Makefile || die 'Failed to remove -Werror via sed'
	if use webui; then
		# Use upstream web archive
		sed -e 's|daed: submodule $(DAE_WING_READY) dist|daed: $(DAE_WING_READY)|' \
			-i Makefile || die
		mv -v "${WORKDIR}/web" "${S}/dist" || die
	fi

	default
}

src_compile(){
	# sed -i '/git submodule update/d' wing/Makefile || die
	# sed -i 's/git rev-parse --short HEAD/echo/' vite.config.ts || die
	if ! use webui; then
		cd wing || die
	fi

	# for dae's ebpf target
	# gentoo-zh#3720
	filter-flags "-march=*" "-mtune=*"
	append-cflags "-fno-stack-protector"

	GO_ROOT="${S}" SKIP_SUBMODULES=1 emake APPNAME="${PN}" VERSION="${PV}"
}

src_install(){
	local service=install/daed.service
	if use webui; then
		dobin daed
		systemd_dounit ${service}
	else
		dobin wing/dae-wing
		sed -i "s!/usr/bin/daed!/usr/bin/dae-wing!" ${service} || die
		systemd_newunit ${service} dae-wing.service
	fi
	keepdir /etc/daed/
	dosym -r "/usr/share/v2ray/geosite.dat" /usr/share/daed/geosite.dat
	dosym -r "/usr/share/v2ray/geoip.dat" /usr/share/daed/geoip.dat

	# thanks to @MarksonHon
	newinitd "${FILESDIR}"/${PN}.initd daed
}

pkg_postinst() {
	elog
	elog "For OpenRC user, if you want to use"
	elog "openrc to manager daed service,"
	elog "please refer to dae document to modify"
	elog "rc.conf and sysfs first, then reboot."
	elog "https://github.com/daeuniverse/dae/blob/main/docs/en/tutorials/run-on-alpine.md"
	elog "Now you can start and add it to default runlevel "
	elog "# rc-service daed start"
	elog "# rc-update add daed default"
	elog
}
