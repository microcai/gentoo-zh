# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

HOMEPAGE="https://github.com/tickstep/aliyunpan"
DESCRIPTION="aliyunpan cli client, support Webdav service, JavaScript plugin"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm ~arm64 ~mips ~ppc64 ~s390 ~x86"
SRC_URI="https://github.com/tickstep/aliyunpan/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/123485k/gentoo-go-deps/releases/download/${P}/${P}-deps.tar.xz"

src_compile() {
	ego build -o bin/${PN} -trimpath
}

src_install() {
	dobin bin/${PN}
}

pkg_postinst() {
	elog "if you see \"FATAL ERROR: config file error: config file permission denied\""
	elog "try \"mkdir ~/.aliyunpan\""
}
