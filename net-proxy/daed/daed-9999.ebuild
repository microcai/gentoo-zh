# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module systemd

DESCRIPTION="A Modern Dashboard For dae"
HOMEPAGE="https://github.com/daeuniverse/daed"
# SRC_URI=""
EGIT_REPO_URI="https://github.com/daeuniverse/daed.git"

LICENSE="MIT AGPL-3"
SLOT="0"
KEYWORDS=""
RESTRICT="strip"

DEPEND="
	app-alternatives/v2ray-geoip
	app-alternatives/v2ray-geosite
"
RDEPEND="${DEPEND}"
BDEPEND="
	webui? ( sys-apps/pnpm )
	sys-devel/clang
"

IUSE="+webui"

src_unpack(){
	git-r3_src_unpack
	cd ${P} || die
	if use webui; then
		pnpm install || die
	fi
	cd wing || die
	ego mod download -modcacherw
	cd dae-core || die
	ego mod download -modcacherw
}

src_compile(){
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
