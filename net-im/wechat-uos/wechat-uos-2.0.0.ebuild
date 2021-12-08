# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit unpacker xdg

DESCRIPTION="UOS wechat"
HOMEPAGE="https://www.chinauos.com/resource/download-professional"

KEYWORDS="~amd64"

SRC_URI="https://cdn-package-store6.deepin.com/appstore/pool/appstore/c/com.qq.weixin/com.qq.weixin_${PV}-2_amd64.deb"

SLOT="0"
RESTRICT="strip mirror" # mirror as explained at bug #547372
LICENSE="MIT"
IUSE=""

RDEPEND="
	dev-libs/nss
	gnome-base/gconf:2
	media-libs/alsa-lib
	media-libs/fontconfig:1.0
	net-print/cups
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:2
	x11-libs/libX11
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	x11-libs/pango
	sys-apps/lsb-release
	sys-apps/bubblewrap
"
DEPEND=""
BDEPEND=""

S="${WORKDIR}"

QA_PREBUILT="
	opt/wechat-uos/libffmpeg.so
	opt/wechat-uos/libnode.so
	opt/wechat-uos/resources/wcs.node
	opt/wechat-uos/wechat
	usr/lib/license/libuosdevicea.so
"

src_install() {
	cat <<- EOF >"${S}/uos-lsb" || die
		DISTRIB_ID=uos
		DISTRIB_RELEASE=20
		DISTRIB_DESCRIPTION=UnionTech OS 20
		DISTRIB_CODENAME=eagle
	EOF
	cat <<- EOF >"${S}/uos-release" || die
		PRETTY_NAME=UnionTech OS Desktop 20 Pro
		NAME=uos
		VERSION_ID=20
		VERSION=20
		ID=uos
		HOME_URL=https://www.chinauos.com/
		BUG_REPORT_URL=http://bbs.chinauos.com
		VERSION_CODENAME=eagle
	EOF
	cat <<- EOF >"${S}/wechat-uos"  || die
		#!/bin/bash -e
		bwrap --dev-bind / / \
		--bind /opt/wechat-uos/crap/uos-release /etc/os-release \
		--bind /opt/wechat-uos/crap/uos-lsb /etc/lsb-release \
		/opt/wechat-uos/wechat
	EOF
	cat <<- EOF >"${S}/wechat-uos.desktop" || die
		[Desktop Entry]
		Name=微信
		Comment=微信 (UOS 魔改版)
		GenericName=微信
		Exec=/usr/bin/wechat-uos %U
		Icon=wechat
		Type=Application
		StartupNotify=true
		Categories=Network;Chat;
	EOF

	exeinto /usr/bin
	exeopts -m0755
	doexe "${S}"/wechat-uos

	insinto /usr/share/icons
	doins -r "${S}"/opt/apps/com.qq.weixin/entries/icons/hicolor
	insinto /usr/share/applications
	doins "${S}"/wechat-uos.desktop

	insinto /usr/lib/license
	doins "${S}"/usr/lib/license/libuosdevicea.so

	insinto /opt/wechat-uos
	doins -r "${S}"/opt/apps/com.qq.weixin/files/*

	insinto /opt/wechat-uos/crap
	doins "${S}"/{uos-lsb,uos-release}

	fperms 0755 /opt/wechat-uos/wechat
}
