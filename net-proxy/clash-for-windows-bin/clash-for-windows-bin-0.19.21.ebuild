# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker xdg-utils

DESCRIPTION="A Windows/macOS/Linux GUI based on Clash and Electron."
HOMEPAGE="https://github.com/Fndroid/clash_for_windows_pkg"
SRC_URI="https://github.com/Fndroid/clash_for_windows_pkg/releases/download/${PV}/Clash.for.Windows-${PV}-x64-linux.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror"

QA_PRESTRIPPED="*"
QA_PREBUILT="*"

RDEPEND="
	x11-libs/gtk+:3
	x11-libs/libXScrnSaver"

S="${WORKDIR}"

src_configure() {
	mv "${S}/Clash for Windows-${PV}-x64-linux" "${S}/${PN}"
	cd "${S}/${PN}/resources/static/files/linux/common/service-installer"
	for f in $(find ../../x64/service/clash-core-service -type f) ; do
		cp ../../x64/service/clash-core-service scripts/
	done
	sed -i '26s/\/usr\/lib/\/lib/g' installer.sh
	sed -i '31s/\/usr\/lib/\/lib/g' installer.sh
	sed -i '53,54s/\/usr\/lib/\/lib/g' installer.sh
	sed -i '75,76s/\/usr\/lib/\/lib/g' installer.sh
}

src_install() {
	insinto "/opt"
	doins -r "${S}/${PN}"
	doicon -s 512 "${FILESDIR}/${PN}.png"
	domenu "${FILESDIR}/${PN}.desktop"
	dosym "/opt/${PN}/cfw" "/usr/bin/cfw"
	fperms 0755 "/opt/${PN}" -R
}

pkg_postinst() {
	ewarn "To use TUN mode, net-firewall/nftables is required."
	xdg_icon_cache_update
}
