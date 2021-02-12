# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

DESCRIPTION="Protect yourself against DNS poisoning in China"
HOMEPAGE="https://github.com/clowwindy/ChinaDNS"

SRC_URI="https://github.com/clowwindy/ChinaDNS/releases/download/${PV}/${P}.tar.gz"
RESTRICT="mirror"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	default
	newinitd "${FILESDIR}/${PN}.initd" ${PN}
	newconfd "${FILESDIR}/${PN}.confd" ${PN}
}
