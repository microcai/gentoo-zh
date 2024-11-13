# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module systemd

DESCRIPTION="A DNS forwarder"
HOMEPAGE="https://github.com/IrineSistiana/mosdns"
SRC_URI="
	https://github.com/IrineSistiana/mosdns/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/peeweep/gentoo-go-deps/releases/download/${P}/${P}-vendor.tar.xz
"

LICENSE="GPL-3"
SLOT="5"
KEYWORDS="~amd64 ~arm64 ~riscv"
IUSE="systemd"

src_compile() {
	local ldflags="\
		-X main.version=${PV} \
		-w -s"
	ego build -o ${P} -trimpath -ldflags "${ldflags}"
	./${P} config gen config.yaml
}

src_install() {
	use systemd && systemd_dounit "${FILESDIR}/mosdns.service"
	newbin ${P} mosdns
	insinto /etc/mosdns/
	doins config.yaml
}
