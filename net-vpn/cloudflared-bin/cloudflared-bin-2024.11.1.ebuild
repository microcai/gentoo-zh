# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

DESCRIPTION="Cloudflare Tunnel client (formerly Argo Tunnel)"
HOMEPAGE="https://github.com/cloudflare/cloudflared"
SRC_URI="https://github.com/cloudflare/cloudflared/releases/download/${PV}/cloudflared-linux-amd64.deb
	-> cloudflared-${PV}-linux-amd64.deb"
S=${WORKDIR}

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-* amd64"

RESTRICT="strip"
QA_PREBUILT="usr/bin/cloudflared"

src_install() {
	dobin "${S}/usr/bin/cloudflared"
	doman "${S}/usr/share/man/man1/cloudflared.1"
}
