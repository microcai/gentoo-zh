# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd

DESCRIPTION="juicity is a quic-based proxy protocol."
HOMEPAGE="https://github.com/juicity/juicity"
SRC_URI="https://github.com/juicity/juicity/releases/download/v${PV}/juicity-full-src.zip -> ${P}.zip"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+server client"

S="$WORKDIR"

src_compile(){
	for i in server client ;do
		if use $i; then
			emake "juicity-$i"
		fi
	done
}

src_install(){
	keepdir "/etc/${PN}"
	insinto "/etc/${PN}"
	for i in server client ;do
		if use $i; then
			dobin "juicity-$i"
			systemd_dounit "install/juicity-$i.service"
			doins "install/example-$i.json"
		fi
	done
}
