# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module systemd

DESCRIPTION="aliyun ddns for golang"
HOMEPAGE="https://github.com/OpenIoTHub/aliddns"

SRC_URI="
	https://github.com/OpenIoTHub/aliddns/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~riscv"
IUSE="systemd"

src_compile() {
	local ldflags="\
		-X main.version=${PV} \
		-w -s"
	ego build -o ${P} -trimpath -ldflags "${ldflags}"
}

src_install() {
	use systemd && systemd_dounit "${FILESDIR}/aliddns.service"
	newbin ${P} aliddns
	insinto /etc/aliddns/
	doins aliddns.yaml
}
