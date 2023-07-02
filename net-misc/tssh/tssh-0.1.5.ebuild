# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module

DESCRIPTION="内置支持 trzsz ( trz / tsz ) 的 ssh 客户端，支持选择（ 搜索 ）服务器进行登录"
HOMEPAGE="https://github.com/trzsz/trzsz-ssh"

SRC_URI="
	https://github.com/trzsz/trzsz-ssh/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/peeweep/gentoo-go-deps/releases/download/${P}/${P}-deps.tar.xz
"

DEPEND=""
RDEPEND="${DEPEND}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~riscv"
IUSE=""
S="${WORKDIR}/trzsz-ssh-${PV}/cmd/tssh"

src_compile() {
	ego build -o bin/${PN} -trimpath -ldflags "-w -s"
}

src_install() {
	dobin bin/${PN}
}
