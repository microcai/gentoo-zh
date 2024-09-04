# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker xdg

DESCRIPTION="Tencent QQ Music, converted from .deb package"
HOMEPAGE="https://y.qq.com/"
SIGN="1725454664-ExMwGMJkwjr8MfNb-0-68c8b626a3eb27b87b031a8ba2fdb5a7"
SRC_URI="https://dldir.y.qq.com/music/clntupate/linux/qqmusic_${PV}_amd64.deb?sign=${SIGN} -> qqmusic_${PV}.deb"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="strip mirror"

RDEPEND="
	x11-libs/gtk+:3
	x11-libs/libXScrnSaver
	dev-libs/nss
"

S="${WORKDIR}"

src_install() {
	insinto /opt
	doins -r opt/*
	fperms +x /opt/qqmusic/{qqmusic,chrome-sandbox,crashpad_handler,libEGL.so,libGLESv2.so,libffmpeg.so,libvk_swiftshader.so,swiftshader/libEGL.so,swiftshader/libGLESv2.so}
	newbin "${FILESDIR}"/qqmusic.sh qqmusic
	domenu "${FILESDIR}"/qqmusic.desktop
	for i in 16 32 64 128 256; do
		doicon -s $i usr/share/icons/hicolor/"$i"x"$i"/apps/qqmusic.png
	done
	gzip -d usr/share/doc/qqmusic/changelog.gz || die
	dodoc usr/share/doc/qqmusic/changelog
}
