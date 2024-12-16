# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop xdg-utils

DESCRIPTION="懒猫微服"
HOMEPAGE="https://lazycat.cloud"
SRC_URI="https://dl.lazycat.cloud/client/desktop/stable/lzc-client-desktop_v${PV}.tar.zst"

S="${WORKDIR}"
LICENSE="all-rights-reserved"
SLOT=0
KEYWORDS="~amd64"
RESTRICT="mirror strip bindist"

RDEPEND="
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	x11-libs/gtk+:3[X,cups]
	x11-libs/libxkbcommon
"

QA_PREBUILT="*"

src_install() {
	newicon -s 512 icon.png lzc-client-desktop.png
	rm icon.png || die

	domenu "${FILESDIR}/lzc-client.desktop"
	rm lzc-client.desktop || die

	insinto /opt/lzc-client-desktop
	doins -r .

	fperms +x /opt/lzc-client-desktop/chrome_crashpad_handler
	fperms +x /opt/lzc-client-desktop/chrome-sandbox
	fperms +x /opt/lzc-client-desktop/rclone
	fperms +x /opt/lzc-client-desktop/lzc-client-desktop
	fperms +x /opt/lzc-client-desktop/core/lzc-core

	dosym -r /opt/lzc-client-desktop/lzc-client-desktop /opt/bin/lzc-client-desktop
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
