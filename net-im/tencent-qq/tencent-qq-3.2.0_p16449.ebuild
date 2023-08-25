# Copyright 2019-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker xdg

MY_PV=${PV/_p/-}

DESCRIPTION="The new version of the official linux-qq"
HOMEPAGE="https://im.qq.com/linuxqq/index.shtml"
LICENSE="Tencent"
RESTRICT="strip"

_I="464d27bd"

SRC_URI="
	amd64? ( https://dldir1.qq.com/qqfile/qq/QQNT/$_I/linuxqq_${MY_PV}_amd64.deb )
	arm64? ( https://dldir1.qq.com/qqfile/qq/QQNT/$_I/linuxqq_${MY_PV}_arm64.deb )
"

SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"

IUSE="bwrap +system-vips split-usr gnome appindicator"
RDEPEND="
	x11-libs/gtk+:3
	x11-libs/libnotify
	dev-libs/nss
	appindicator? ( dev-libs/libayatana-appindicator )
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	x11-misc/xdg-utils
	app-accessibility/at-spi2-core:2
	app-crypt/libsecret
	virtual/krb5
	sys-apps/keyutils
	sys-devel/gcc:12
	system-vips? (
		dev-libs/glib
		>=media-libs/vips-8.14.2
	)
	bwrap? (
		sys-apps/bubblewrap
		x11-misc/snapd-xdg-open
		x11-misc/flatpak-xdg-utils
	)
	gnome? ( dev-libs/gjs )
"

S=${WORKDIR}

src_install() {
	insinto /opt
	doins -r opt/*

	if use system-vips; then
		rm -r "${D}"/opt/QQ/resources/app/sharp-lib || die
	fi

	fperms +x /opt/QQ/{qq,chrome_crashpad_handler,chrome-sandbox,libEGL.so,libffmpeg.so,libGLESv2.so,libvk_swiftshader.so,libvulkan.so.1}

	if use bwrap; then
		exeinto /opt/QQ
		if use split-usr; then
			doexe "${FILESDIR}"/start-script/split-usr/start.sh
		else
			doexe "${FILESDIR}"/start-script/merge-usr/start.sh
		fi
		sed -i 's!/opt/QQ/qq!/opt/QQ/start.sh!' usr/share/applications/qq.desktop || die
		insinto /opt/QQ/workarounds
		doins "${FILESDIR}"/{config.json,xdg-open.sh}
		fperms +x /opt/QQ/workarounds/xdg-open.sh
	else
		sed -i 's!/opt/QQ/qq!/usr/bin/qq!' usr/share/applications/qq.desktop || die
	fi

	if use bwrap; then
		dosym -r /opt/QQ/start.sh /usr/bin/qq
	else
		newbin "$FILESDIR/qq.sh" qq
	fi

	# https://bugs.gentoo.org/898912
	if use appindicator; then
		dosym ../../usr/lib64/libayatana-appindicator3.so /opt/QQ/libappindicator3.so
	fi

	sed -i 's!/usr/share/icons/hicolor/512x512/apps/qq.png!qq!' usr/share/applications/qq.desktop || die
	domenu usr/share/applications/qq.desktop
	doicon -s 512 usr/share/icons/hicolor/512x512/apps/qq.png
	gzip -d usr/share/doc/linuxqq/changelog.gz || die
	dodoc usr/share/doc/linuxqq/changelog
}
