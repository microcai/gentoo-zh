# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop xdg

DESCRIPTION="Weixin for Linux"
HOMEPAGE="https://linux.weixin.qq.com"
SRC_URI="
	amd64? ( https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_x86_64.deb -> wechat-${PV}_x86_64.deb )
	arm64? ( https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_arm64.deb -> wechat_${PV}_arm64.deb )
	loong? ( https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_LoongArch.deb -> wechat_${PV}_loongarch64.deb )
"
S=${WORKDIR}

LICENSE="all-rights-reserved"

SLOT="0"
KEYWORDS="-* ~amd64 ~arm64 ~loong"
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
	loong? ( virtual/loong-ow-compat )
"
QA_PREBUILT="*"

src_prepare() {
	default

	# add any QA scanelf alert files here.
	local so_files=(
		"RadiumWMPF/runtime/libilink2.so"
		"RadiumWMPF/runtime/libilink_network.so"
		"libilink2.so"
		"libilink_network.so"
		"libconfService.so"
		"libvoipChannel.so"
		"libvoipCodec.so"
	)

	for file in "${so_files[@]}"; do
		patchelf --set-rpath '$ORIGIN' "opt/wechat/${file}" || die
	done
}

src_install() {
	dodir /opt/wechat
	cp -r opt/wechat/. "${D}/opt/wechat/" || die

	dosym ../wechat/wechat /opt/bin/wechat

	local exec_envs=( "QT_AUTO_SCREEN_SCALE_FACTOR=1" "\"QT_QPA_PLATFORM=wayland;xcb\"" )
	if use fcitx; then
		exec_envs+=( "QT_IM_MODULE=fcitx" )
	fi
	if use ibus; then
		exec_envs+=( "QT_IM_MODULE=ibus" )
	fi

	sed -i \
		-e "s|^Icon=.*|Icon=wechat|" \
		-e "s|^Categories=.*|Categories=Network;InstantMessaging;Chat;|" \
		-e "s|^Exec=.*|Exec=env ${exec_envs[*]} wechat %U|" \
		usr/share/applications/wechat.desktop || die
	domenu usr/share/applications/wechat.desktop

	insinto /usr/share
	doins -r usr/share/icons
}
