# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker xdg

MY_PV=${PV/_beta1_p/-}

DESCRIPTION="The new version of the official linux-qq"
HOMEPAGE="https://im.qq.com/linuxqq/download.html"
LICENSE="Tencent"
RESTRICT="strip"

SRC_URI="
	amd64? ( https://dldir1.qq.com/qqfile/qq/QQNT/4691a571/QQ-v${MY_PV}_x64.deb )
"

SLOT="nt"
KEYWORDS="~amd64"

RDEPEND="
	x11-libs/gtk+:3
	x11-libs/libnotify
	dev-libs/nss
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	x11-misc/xdg-utils
	app-accessibility/at-spi2-core:2
	app-crypt/libsecret
"

S=${WORKDIR}

src_install() {
	insinto /opt
	doins -r opt/*

	fperms +x /opt/QQ/{qq,chrome_crashpad_handler,chrome-sandbox,libEGL.so,libffmpeg.so,libGLESv2.so,libvk_swiftshader.so,libvulkan.so.1}
	printf "#!/bin/bash\ncd /opt/QQ\n./qq \$@\n" > qq || die
	dobin qq

	domenu usr/share/applications/qq.desktop
	gzip -d usr/share/doc/linuxqq/changelog.gz || die
	dodoc usr/share/doc/linuxqq/changelog
}
