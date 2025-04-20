# Copyright 2020-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="BaiduPCS-Go"

inherit go-module

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/qjfoidnh/${MY_PN}.git"
	src_unpack() {
		git-r3_src_unpack
	}
else
	SRC_URI="https://github.com/qjfoidnh/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/gentoo-zh/gentoo-deps/releases/download/${P}/${P}-vendor.tar.xz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${MY_PN}-${PV}"
fi

DESCRIPTION="The terminal utility for Baidu Network Disk (Golang Version)."
HOMEPAGE="https://github.com/qjfoidnh/BaiduPCS-Go"

LICENSE="Apache-2.0"
SLOT="0"

src_compile() {
	local ldflags="-w -s"
	ego build -o ${PN} -trimpath -ldflags "${ldflags}"
}

src_install() {
	dobin ${PN}
}
