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
	dev-libs/v2ray-domain-list-community-bin
	dev-libs/v2ray-geoip-bin
"
RDEPEND="${DEPEND}"
BDEPEND="
	sys-apps/pnpm
	sys-devel/clang
"

src_unpack(){
	git-r3_src_unpack
	cd ${P} || die
	pnpm install || die
	cd wing || die
	ego mod download -modcacherw
	cd dae-core || die
	ego mod download -modcacherw
}

src_compile(){
	GO_ROOT="${S}" emake CC=clang CFLAGS="$CFLAGS -fno-stack-protector"
}

src_install(){
	dobin daed
	systemd_dounit install/daed.service
	keepdir /etc/daed/
	dosym -r "/usr/share/v2ray/geosite.dat" /usr/share/daed/geosite.dat
	dosym -r "/usr/share/v2ray/geoip.dat" /usr/share/daed/geoip.dat
}
