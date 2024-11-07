# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop xdg

DESCRIPTION="Weixin for Linux"
HOMEPAGE="https://linux.weixin.qq.com"
SRC_URI="https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_x86_64.deb -> WeChatLinux-${PV}_x86_64.deb"
S=${WORKDIR}

LICENSE="all-rights-reserved"

SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="+fcitx ibus"
REQUIRED_USE="^^ ( fcitx ibus )"

RESTRICT="strip mirror bindist"
BDEPEND="
	dev-util/patchelf
"
RDEPEND="
	app-accessibility/at-spi2-core
	dev-libs/nss
	media-libs/libpulse
	media-libs/mesa
	virtual/jack
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libxkbcommon[X]
	x11-libs/libXrandr
	x11-libs/pango
	x11-libs/xcb-util-image
	x11-libs/xcb-util-keysyms
	x11-libs/xcb-util-renderutil
	x11-libs/xcb-util-wm
"
QA_PREBUILT="*"

src_prepare() {
	default

	local so_files=(
		"RadiumWMPF/runtime/libilink2.so"
		"RadiumWMPF/runtime/libilink_network.so"
		"libilink2.so"
		"libilink_network.so"
		"libconfService.so"
		"libvoipChannel.so"
		"libvoipCodec.so"
		"libwxtrans.so"
	)

	for file in "${so_files[@]}"; do
		patchelf --set-rpath '$ORIGIN' "${S}/opt/wechat/${file}" || die
	done

	find "${S}/opt/wechat/vlc_plugins" -type f | xargs -I {} patchelf --set-rpath '$ORIGIN:$ORIGIN/../..' {} || die

	local env_vars="QT_AUTO_SCREEN_SCALE_FACTOR=1 \"QT_QPA_PLATFORM=wayland;xcb\""
	if use fcitx; then
	    env_vars="QT_IM_MODULE=fcitx ${env_vars}"
	elif use ibus; then
	    env_vars="QT_IM_MODULE=ibus ${env_vars}"
	fi

	sed -i \
		-e "s|^Icon=.*|Icon=wechat|" \
		-e "s|^Categories=.*|Categories=Network;InstantMessaging;Chat;|" \
		-e "/^Exec=/s|Exec=|Exec=env ${env_vars} |" \
		"${S}/usr/share/applications/wechat.desktop" || die
}

src_install() {
	insinto /usr/share
	doins -r "${S}/usr/share/icons"

	insinto /opt
	doins -r "${S}/opt/wechat"

	fperms 755 /opt/wechat/crashpad_handler
	fperms 755 /opt/wechat/RadiumWMPF/runtime/WeChatAppEx
	fperms 755 /opt/wechat/RadiumWMPF/runtime/WeChatAppEx_crashpad_handler
	fperms 755 /opt/wechat/wechat
	fperms 755 /opt/wechat/wxocr
	fperms 755 /opt/wechat/wxplayer

	dosym -r /opt/wechat/wechat /usr/bin/wechat
	domenu "${S}/usr/share/applications/wechat.desktop"
}
