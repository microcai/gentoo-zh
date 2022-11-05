# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Chinese-specific configuration to improve your favorite DNS server."
HOMEPAGE="https://github.com/felixonmars/dnsmasq-china-list"

EGIT_REPO_URI="https://github.com/felixonmars/dnsmasq-china-list.git"
EGIT_CLONE_TYPE=shallow

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+dnsmasq smartdns"

RDEPEND="
	${DEPEND}
	dnsmasq? ( net-dns/dnsmasq )
	smartdns? ( net-dns/smartdns )
"

src_compile() {
	if use smartdns ; then
		make smartdns SERVER=china
		rm bogus-nxdomain.china.smartdns.conf
	fi
}

src_install() {
	if use dnsmasq ; then
		insinto /etc/dnsmasq.d/
		dobin dnsmasq-update-china-list
		doins *.china.conf
	fi
	if use smartdns ; then
		insinto /etc/smartdns/
		doins *.china.smartdns.conf
	fi
}
