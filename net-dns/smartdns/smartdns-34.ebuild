# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

DESCRIPTION="SmartDNS is a local DNS server. It returns the fastest access results to clients"
HOMEPAGE="https://github.com/pymumu/smartdns"

SRC_URI="https://github.com/pymumu/smartdns/archive/refs/tags/Release${PV}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/smartdns-Release${PV}"
