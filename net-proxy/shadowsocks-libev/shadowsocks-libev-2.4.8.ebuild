# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/shadowsocks-libev/shadowsocks-libev-2.0.4.ebuild,v 1.1 2015/01/11 14:02:48 dlan Exp $

EAPI=7

inherit eutils systemd

DESCRIPTION="A lightweight secured scoks5 proxy for embedded devices and low end boxes"
HOMEPAGE="https://github.com/shadowsocks/shadowsocks-libev"

RESTRICT="mirror"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/shadowsocks/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/shadowsocks/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"

fi

LICENSE="GPL-3+"
SLOT="0"
IUSE="debug +openssl polarssl systemd"

DEPEND="openssl? ( dev-libs/openssl )
	polarssl? ( net-libs/polarssl )
	systemd? ( sys-apps/systemd )
	app-text/asciidoc
	"
RDEPEND="${DEPEND}"

REQUIRED_USE=" ^^ ( openssl polarssl )"

src_configure() {
	econf \
		$(use_enable debug assert) \
		--with-crypto-library=$(usex openssl openssl polarssl)
}

src_install() {
	default
	prune_libtool_files --all

	insinto "/etc/"
	newins "${FILESDIR}/shadowsocks.json" shadowsocks.json

	newinitd "${FILESDIR}/shadowsocks.initd" shadowsocks
	dosym /etc/init.d/shadowsocks /etc/init.d/shadowsocks.server
	dosym /etc/init.d/shadowsocks /etc/init.d/shadowsocks.client

	if use systemd ; then
		systemd_dounit "${FILESDIR}/shadowsocks-server.service"
		systemd_dounit "${FILESDIR}/shadowsocks-client.service"
	fi
}

pkg_setup() {
	elog "You need to choose to run as server or client mode"
	elog "  server: rc-update add shadowsocks.server default"
	elog "  client: rc-update add shadowsocks.client default"
}
