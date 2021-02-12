# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic googlecode

DESCRIPTION="Red Gaint (RuiJie) EAP-MD5 authentication client in Linux"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="firewall"
RESTRICT="mirror"

DEPEND=">=dev-lang/python-2.4"
RDEPEND=">=dev-lang/python-2.4
		firewall? ( net-firewall/iptables )"

src_install(){
	dodoc README
	insinto /etc
	doins 8021x.exe
	doins xmuruijie.conf
	exeinto /usr/sbin
	newexe xmuruijie.py xmuruijie
	if use firewall; then
		newins "${FILESDIR}"/iptables_rules.bak iptables_rules.bak
		newinitd "${FILESDIR}"/localip localip
		newinitd "${FILESDIR}"/saier-fw saier
		newinitd "${FILESDIR}"/ruijie-fw ruijie
	else
		newinitd "${FILESDIR}"/saier saier
		newinitd "${FILESDIR}"/ruijie ruijie
	fi
}

pkg_postinst() {
	einfo
	ewarn "Please set you own configuration in"
	ewarn "/etc/xmuruijie.conf first."
	einfo
	einfo "If you use dynamic IP"
	einfo "\tYou need use: /etc/init.d/ruijie start | stop to begin or stop"
	einfo
	einfo "If you use Static IP"
	ewarn "\tYou need to change the DNS in /etc/init.d/saier to yours first,"
	einfo "\tthen, set your IP and router in /etc/init.d/net as usual"
	einfo "\tfinally, use: /etc/init.d/saier start | stop to begin or stop"
	einfo
	if use firewall; then
		ewarn "You choose the firewall rules support,"
		ewarn "\tBefore you start to use ruijie or saier,"
		ewarn "\tBe sure you have add your own rules into /etc/iptables_rules.bak"
		ewarn "\tThe icmp_packets chain is neccessay for pinging from your own machine !"
		einfo
	fi
}
