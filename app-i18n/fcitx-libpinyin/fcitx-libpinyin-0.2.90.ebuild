# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils gnome2-utils

DESCRIPTION="Libpinyin Wrapper for Fcitx."
HOMEPAGE="https://github.com/fcitx/fcitx-libpinyin"
SRC_URI="http://fcitx.googlecode.com/files/${P}_dict.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+pinyin +shuangpin +zhuyin"
REQUIRED_USE="|| ( pinyin shuangpin zhuyin )"

RESTRICT="mirror"

RDEPEND=">=app-i18n/fcitx-4.2.4
	>=app-i18n/libpinyin-0.8.93
	dev-libs/glib:2"
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext"

src_install() {
	cmake-utils_src_install

	# filter out unneeded input method

	if ! use pinyin; then
		rm ${D}/usr/share/fcitx/inputmethod/pinyin-libpinyin.conf
	fi

	if ! use shuangpin; then
		rm ${D}/usr/share/fcitx/inputmethod/shuangpin-libpinyin.conf
	fi

	if ! use zhuyin; then
		rm ${D}/usr/share/fcitx/inputmethod/zhuyin-libpinyin.conf
		rm -rf ${D}/usr/share/fcitx/libpinyin/zhuyin_data
		rm ${D}/usr/share/icons/hicolor/48x48/status/fcitx-bopomofo.png
	fi
}

pkg_postinst() {
	use zhuyin && gnome2_icon_cache_update
}

pkg_postrm() {
	use zhuyin && gnome2_icon_cache_update
}
