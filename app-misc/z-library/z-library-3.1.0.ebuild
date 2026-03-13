# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop xdg

DESCRIPTION="Z-library application"
HOMEPAGE="https://z-lib.fm/z-access"
URI_PREFIX="https://s3proxy-alp.cdn-zlib.sk/swfs_second_public_files/soft/desktop/Z-Library_"
SRC_URI="${URI_PREFIX}${PV}_amd64.deb"

S="${WORKDIR}"
LICENSE="ISC"

SLOT="0"
KEYWORDS="-* ~amd64"

RESTRICT="strip"

RDEPEND="
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
"

src_install() {
	insinto /opt/Z-Library
	doins -r "${S}"/opt/Z-Library/.
	fperms +x /opt/Z-Library/Z-Library
	fperms +x /opt/Z-Library/chrome-sandbox
	fperms +x /opt/Z-Library/chrome_crashpad_handler

	domenu "${S}"/usr/share/applications/Z-Library.desktop

	for size in 16 32 128 256 512; do
		doicon -s ${size} "${S}"/usr/share/icons/hicolor/${size}x${size}/apps/Z-Library.png
	done
}
