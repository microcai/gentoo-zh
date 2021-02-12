# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd

DESCRIPTION="Socks5 proxy written in Erlang"
HOMEPAGE="https://github.com/yueyoum/make-proxy"
SRC_URI="https://github.com/yueyoum/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="make-proxy"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+client server systemd"

DEPEND="dev-lang/erlang
	systemd? ( sys-apps/systemd ) "
RDEPEND="${DEPEND}"

src_compile() {
	if use client ; then
		make client
	fi

	if use server ; then
		make server
	fi
}

src_install() {
	insinto "/opt/${PN}"
	doins -r .

	insinto "/etc/${PN}"

	if use client ; then
		newins client.config.example client.config

		doinitd "${FILESDIR}/mp-client"
	fi

	if use server ; then
		newins server.config.example server.config

		doinitd "${FILESDIR}/mp-server"
	fi

	newdoc README.md "${PN}".md

	if use systemd ; then
		if use client ; then
			systemd_dounit "${FILESDIR}/mp-client.service"
		fi

		if use server ; then
			systemd_dounit "${FILESDIR}/mp-server.service"
		fi
	fi
}
