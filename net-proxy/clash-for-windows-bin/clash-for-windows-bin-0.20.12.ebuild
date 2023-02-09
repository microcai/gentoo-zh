# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker xdg-utils

DESCRIPTION="A Windows/macOS/Linux GUI based on Clash and Electron."
HOMEPAGE="https://github.com/Fndroid/clash_for_windows_pkg"
SRC_URI="https://github.com/Fndroid/clash_for_windows_pkg/releases/download/${PV}/Clash.for.Windows-${PV}-x64-linux.tar.gz"

LICENSE="no-source-code"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+tun"

RESTRICT="mirror strip"

QA_PRESTRIPPED="*"
QA_PREBUILT="*"

RDEPEND="
	x11-libs/gtk+:3
	x11-libs/libXScrnSaver
	dev-libs/nss
	tun? ( net-firewall/nftables )"

S="${WORKDIR}"

src_configure() {
	mv "${S}/Clash for Windows-${PV}-x64-linux" "${S}/${PN}"
}

src_install() {
	insinto "/opt"
	doins -r "${S}/${PN}"
	doicon -s 512 "${FILESDIR}/${PN}.png"
	domenu "${FILESDIR}/${PN}.desktop"
	dosym -r "/opt/${PN}/cfw" "/usr/bin/cfw"
	fperms 0755 "/opt/${PN}" -R
	newinitd "${FILESDIR}"/clash-core-service.initd clash-core-service
}

pkg_postinst() {
	elog
	elog "For OpenRC user, if you need Service Mode, "
	elog "please start and add clash daemon to default runlevel"
	elog "# rc-service clash-core-service start"
	elog "# rc-update add clash-core-service default"
	elog
	xdg_icon_cache_update
}
