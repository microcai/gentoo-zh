# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

DESCRIPTION="Close-sourced pre-built Clash binary with TUN support"
HOMEPAGE="https://github.com/Dreamacro/clash"
SRC_URI="
	amd64? ( https://release.dreamacro.workers.dev/${PV}/clash-linux-amd64-${PV}.gz )
	arm64? ( https://release.dreamacro.workers.dev/${PV}/clash-linux-arm64-${PV}.gz )
"
LICENSE="all-rights-reserved"

SLOT="0"
KEYWORDS="~amd64 ~arm64"
RDEPEND="!net-proxy/clash"

S="${WORKDIR}"

src_install() {
	newbin clash-linux* clash
	# Thanks to liuyujielol for service files
	systemd_newunit "${FILESDIR}/clash-r1.service" clash.service
	newinitd "${FILESDIR}"/clash.initd clash
	newconfd "${FILESDIR}"/clash.confd clash
	keepdir /etc/clash
}
