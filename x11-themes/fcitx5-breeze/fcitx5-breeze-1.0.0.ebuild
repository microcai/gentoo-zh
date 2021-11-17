# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Fcitx5 theme to match KDE's Breeze style."
HOMEPAGE="https://github.com/scratch-er/fcitx5-breeze"
SRC_URI="https://github.com/scratch-er/fcitx5-breeze/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="
	app-i18n/fcitx5"
BDEPEND=""

src_install() {
	install_dir="/usr/share/fcitx5/themes"
	insinto "${install_dir}/breeze"
	newins "${S}/theme_light.conf" "theme.conf"
	newins "${S}/prev.png" "prev.png"
	newins "${S}/next.png" "next.png"
	newins "${S}/arrow.png" "arrow.png"
	newins "${S}/radio.png" "radio.png"
	newins "${S}/panel.png" "panel.png"
	newins "${S}/highlight.png" "highlight.png"
	insinto "${install_dir}/breeze-dark"
	newins "${S}/theme_dark.conf" "theme.conf"
	newins "${S}/panel_dark.png" "panel.png"
	insinto "${install_dir}/breeze-translucent"
	newins "${S}/theme_light_translucent.conf" "theme.conf"
	newins "${S}/panel_light_translucent.png" "panel.png"
	insinto "${install_dir}/breeze-dark-translucent"
	newins "${S}/theme_dark_translucent.conf" "theme.conf"
	newins "${S}/panel_dark_translucent.png" "panel.png"
	for dirname in breeze-dark breeze-translucent breeze-dark-translucent; do
		for filename in prev.png next.png arrow.png radio.png highlight.png; do
			dosym "${install_dir}/breeze/${filename}" "${install_dir}/${dirname}/${filename}"
		done
	done
}
