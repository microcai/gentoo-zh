# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit eutils games

DESCRIPTION="Limbo"
SRC_URI="http://c732102.r2.cf2.rackcdn.com/LIMBOInstaller.exe"
HOMEPAGE="http://limbogame.org"
LICENSE="unknown"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""

DEPEND="app-arch/p7zip"
RDEPEND=">=app-emulation/wine-1.5.2[win32]
         >=app-emulation/winetricks-744"

src_unpack() {
	# Multiple settings.txt exist in LIMBOInstaller.exe, we must select the skip option by echoing "s\n"
	echo "s\n" | 7z x "${DISTDIR}/${A}" -o"${WORKDIR}"

	# Restruct the directory. 
        rm -rf "${WORKDIR}"/$'\x01\x19'
        rm -rf "${WORKDIR}"/$'\x01\x15'/$'\x01\x1A'
        mkdir "${WORKDIR}/default-config"
        mkdir "${WORKDIR}/Limbo"
        mv "${WORKDIR}"/$'\x01\x15'/settings.txt "${WORKDIR}/default-config"
        mv "${WORKDIR}"/$'\x01\x15'/*            "${WORKDIR}/Limbo"
        rmdir "${WORKDIR}"/$'\x01\x15'
}

src_prepare() {
	# Prepare the wrapper script
	sed -e "s/^GAMEDIR=.*$/GAMEDIR=\/opt\/limbo/g" \
	    -e "s/^DATADIR=.*$/DATADIR=~\/.local\/share\/limbo/g" "${FILESDIR}/limbo" > "${WORKDIR}/limbo"
}

src_install() {
	dodir "${GAMES_PREFIX_OPT}/limbo"
	cp -r "default-config" "${D}/${GAMES_PREFIX_OPT}/limbo"
	cp -r "Limbo"          "${D}/${GAMES_PREFIX_OPT}/limbo"

	dogamesbin "limbo"
	doicon "${FILESDIR}/limbo.png"
	domenu "${FILESDIR}/limbo.desktop"

	prepgamesdirs
}
