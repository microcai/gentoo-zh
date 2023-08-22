# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

DESCRIPTION="A Modern Dashboard For dae"
HOMEPAGE="https://github.com/daeuniverse/daed"
SRC_URI="
	https://github.com/daeuniverse/daed/releases/download/v${PV/_p1/.p1}/daed-full-src.zip -> ${P}.zip
	webui? ( https://github.com/st0nie/gentoo-go-deps/releases/download/${P}/${P}-node_modules-pnpm.tar.xz )
"
# EGIT_REPO_URI="https://github.com/daeuniverse/daed.git"

LICENSE="MIT AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip"

DEPEND="
	app-alternatives/v2ray-geoip
	app-alternatives/v2ray-geosite
"
RDEPEND="${DEPEND}"
BDEPEND="
	webui? ( sys-apps/pnpm )
	sys-devel/clang
	app-arch/unzip
	dev-lang/go
"
S="${WORKDIR}"

IUSE="+webui"

src_compile(){
	# sed -i '/git submodule update/d' wing/Makefile || die
	# sed -i 's/git rev-parse --short HEAD/echo/' vite.config.ts || die
	if ! use webui; then
		cd wing || die
	fi
	GO_ROOT="${S}" emake CC=clang CFLAGS="$CFLAGS -fno-stack-protector" APPNAME="${PN}" VERSION="${PV}"
}

src_install(){
	local service=install/daed.service
	if use webui; then
		dobin daed
		systemd_dounit $service
	else
		dobin wing/dae-wing
		sed -i "s!/usr/bin/daed!/usr/bin/dae-wing!" $service || die
		systemd_newunit $service dae-wing.service
	fi
	keepdir /etc/daed/
	dosym -r "/usr/share/v2ray/geosite.dat" /usr/share/daed/geosite.dat
	dosym -r "/usr/share/v2ray/geoip.dat" /usr/share/daed/geoip.dat
}
