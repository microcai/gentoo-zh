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

IUSE="bwrap"
RDEPEND="
	x11-libs/gtk+:3
	x11-libs/libnotify
	dev-libs/nss
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	x11-misc/xdg-utils
	app-accessibility/at-spi2-core:2
	app-crypt/libsecret
	bwrap? ( sys-apps/bubblewrap )
"

S=${WORKDIR}

src_install() {
	insinto /opt
	doins -r opt/*

	fperms +x /opt/QQ/{qq,chrome_crashpad_handler,chrome-sandbox,libEGL.so,libffmpeg.so,libGLESv2.so,libvk_swiftshader.so,libvulkan.so.1}
	printf "#!/bin/bash\ncd /opt/QQ\n./qq \$@\n" > qq || die
	if use bwrap ;then
		sed -i 's!./qq!/opt/QQ/start.sh!' qq || die
	fi
	dobin qq

	if use bwrap ;then
		exeinto /opt/QQ
		doexe "${FILESDIR}"/start.sh
		sed -i 's!/opt/QQ/qq!/opt/QQ/start.sh!' usr/share/applications/qq.desktop || die
	else
		sed -i 's!/opt/QQ/qq!/usr/bin/qq!' usr/share/applications/qq.desktop || die
	fi

	sed -i 's!/opt/QQ/resources/app/512x512.png!qq!' usr/share/applications/qq.desktop || die
	domenu usr/share/applications/qq.desktop
	doicon -s 512 usr/share/icons/hicolor/0x0/apps/qq.png
	gzip -d usr/share/doc/linuxqq/changelog.gz || die
	dodoc usr/share/doc/linuxqq/changelog
}
