# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

DESCRIPTION="UU Game Accelerator for Linux"
HOMEPAGE="https://uu.163.com/"
SRC_URI="https://uu.gdl.netease.com/uuplugin/steam-deck-plugin-x86_64/v${PV}/uu.tar.gz -> ${P}.tar.gz"

S=${WORKDIR}

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror strip bindist"

QA_PREBUILT="usr/bin/uuplugin"

src_install() {
	dobin uuplugin
	insinto /etc/uuplugin
	doins uu.conf
	systemd_dounit "${FILESDIR}/uuplugin.service"
}
