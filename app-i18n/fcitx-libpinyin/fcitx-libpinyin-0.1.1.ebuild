# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils

DESCRIPTION="Libpinyin Wrapper for Fcitx."
HOMEPAGE="https://github.com/fcitx/fcitx-libpinyin"
SRC_URI="http://fcitx.googlecode.com/files/${P}.tar.xz
	https://github.com/downloads/fcitx/fcitx-libpinyin/model.text.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="+pinyin +shuangpin +zhuyin"

RESTRICT="mirror"

RDEPEND=">=app-i18n/fcitx-4.2.0
	>=app-i18n/libpinyin-0.5.0"
DEPEND="${RDEPEND}
	dev-util/intltool"

pkg_setup(){
	local uu=false;

	for u in "pinyin shuangpin zhuyin" ; do
		use $u && uu=true
	done

	$uu || die "You must spicify at least one input method!
try 'USE=pinyin emerge $PN' again"

}

src_prepare() {
	cp "${DISTDIR}/model.text.tar.gz" "${S}/data" || die "model.text.tar.gz is not found"
}

src_install(){
	cmake-utils_src_install
	
	# filter out unneeded input method
	
	use pinyin || rm ${D}/usr/share/fcitx/inputmethod/pinyin-libpinyin.conf
	use shuangpin || rm ${D}/usr/share/fcitx/inputmethod/shuangpin-libpinyin.conf
	use zhuyin || rm ${D}/usr/share/fcitx/inputmethod/zhuyin-libpinyin.conf
	use zhuyin || rm -rf ${D}/usr/share/fcitx/libpinyin/zhuyin_data
}
