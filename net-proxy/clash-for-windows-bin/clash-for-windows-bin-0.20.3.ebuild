# Copyright 1999-2022 Gentoo Authors
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

RESTRICT="mirror"

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
}

pkg_postinst() {
	xdg_icon_cache_update
}
