# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd

DESCRIPTION="A Control Panel for v2ray"
HOMEPAGE="https://github.com/sprov065/v2-ui"
SRC_URI="https://github.com/sprov065/v2-ui/releases/download/${PV}/v2-ui-linux.tar.gz -> ${P}-linux.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/v2-ui"

src_prepare() {
	default
	sed -i -e "s|/usr/local|/opt|g" \
		"$S"/v2-ui.service
}

src_install() {
	insinto /opt/
	cp -rf "$S" "$D/opt" || die

	newinitd "${FILESDIR}/v2-ui.initd" v2-ui
	systemd_dounit v2-ui.service
}
