# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module

DESCRIPTION="A lightweight and high-performance transparent proxy solution based on eBPF"
HOMEPAGE="https://github.com/v2rayA/dae"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS=""

EGIT_REPO_URI="https://github.com/v2rayA/dae.git"

BDEPEND="sys-devel/clang"

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
}
