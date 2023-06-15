# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 systemd

DESCRIPTION="A Modern Dashboard For dae"
HOMEPAGE="https://github.com/daeuniverse/daed"
# SRC_URI=""
EGIT_REPO_URI="https://github.com/daeuniverse/daed.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
RESTRICT="strip"

# DEPEND=""
# RDEPEND="${DEPEND}"
BDEPEND="
	sys-apps/pnpm
	sys-devel/clang
"

src_unpack(){
	git-r3_src_unpack
	cd ${P} || die
	pnpm install || die
	cd wing || die
	emake CC=clang CFLAGS="$CFLAGS -fno-stack-protector" deps
}

src_compile(){
	pnpm build || die
	cd wing || die
	emake OUTPUT=../daed WEB_DIST=../dist bundle
}

src_install(){
	dobin daed
	systemd_dounit install/daed.service
	keepdir /etc/dae/
}
