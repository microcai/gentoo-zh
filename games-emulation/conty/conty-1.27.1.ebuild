# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit linux-info desktop

NAME="${PN}_dwarfs.sh"
DESCRIPTION="SquashFS image of Arch Linux with: Lutris, Steam, Bottles, Wine..."
HOMEPAGE="https://github.com/Kron4ek/Conty"
SRC_URI="https://github.com/Kron4ek/Conty/releases/download/${PV}/${NAME} -> $P"
S="${WORKDIR}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
RESTRICT="strip"
RDEPEND="sys-fs/fuse:0"
QA_PREBUILT="*"
CONFIG_CHECK="
	IA32_EMULATION
	USER_NS
"
src_install() {
	newbin "${DISTDIR}/${P}" $PN

	domenu "${FILESDIR}/${PN}-lutris.desktop"
	domenu "${FILESDIR}/${PN}-steam.desktop"
	domenu "${FILESDIR}/${PN}-bottles.desktop"
	domenu "${FILESDIR}/${PN}-genymotion.desktop"
	domenu "${FILESDIR}/${PN}-nautilus.desktop"
}
pkg_postinst() {
	einfo "How to use: $ ${NAME} [command] [command_arguments]"
	einfo "For example: ${NAME} steam"
	einfo "or"
	einfo "WINEPREFIX=$HOME/wine-conty ${NAME} gamescope -f -- wine ./game.exe"
	einfo "but for simplicity use lutris here - you will get GUI for Wine options"
	einfo "also --help is available"
}
