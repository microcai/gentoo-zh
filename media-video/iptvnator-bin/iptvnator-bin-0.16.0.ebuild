# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop xdg

DESCRIPTION="Cross-platform IPTV player application with multiple features"
HOMEPAGE="https://iptvnator.vercel.app/"
SRC_URI="https://github.com/4gray/iptvnator/releases/download/v${PV}/iptvnator_${PV}_amd64.deb"

S="${WORKDIR}"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64"

RESTRICT="strip"

src_install() {
	insinto /opt/IPTVnator
	doins -r "${S}"/opt/IPTVnator/.
	fperms +x /opt/IPTVnator/iptvnator
	fperms +x /opt/IPTVnator/chrome-sandbox
	fperms +x /opt/IPTVnator/chrome_crashpad_handler

	domenu "${S}"/usr/share/applications/iptvnator.desktop

	for size in 192 256 512 1024; do
		doicon -s ${size} "${S}"/usr/share/icons/hicolor/${size}x${size}/apps/iptvnator.png
	done
}
