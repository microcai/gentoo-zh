# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="fcitx5-pinyin-sougou-baidu"

DESCRIPTION="Sougou & Baidu Pinyin dictionary for Fcitx5 and RIME"
HOMEPAGE="https://github.com/blackteahamburger/fcitx5-pinyin-sougou-baidu"
SRC_URI="
	https://github.com/blackteahamburger/${MY_PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	sougou? ( https://github.com/blackteahamburger/${MY_PN}/releases/download/${PV}/sougou_dict.tar.gz
		-> sougou_dict-${PV}.tar.gz )
	baidu? ( https://github.com/blackteahamburger/${MY_PN}/releases/download/${PV}/baidu_dict.tar.gz
		-> baidu_dict-${PV}.tar.gz )
"

S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="Unlicense"
SLOT="5"
KEYWORDS="~amd64"
IUSE="+fcitx rime +sougou +baidu"
REQUIRED_USE="
	|| ( fcitx rime )
	|| ( sougou baidu )
"

RDEPEND="
	fcitx? ( app-i18n/fcitx:5 )
	rime? ( || ( app-i18n/ibus-rime app-i18n/fcitx-rime ) )
"
BDEPEND="
	fcitx? ( app-i18n/libime:5 )
	>=app-text/imewlconverter-3.1.1
"

src_unpack() {
	default
	use sougou && cp -r "${WORKDIR}/sougou_dict" "${S}" || die
	use baidu && cp -r "${WORKDIR}/baidu_dict" "${S}" || die
}

src_compile() {
	if use fcitx; then
		use sougou && emake sougou.dict
		use baidu && emake baidu.dict
	fi

	if use rime; then
		use sougou && emake sougou.dict.yaml
		use baidu && emake baidu.dict.yaml
	fi
}

src_install() {
	if use fcitx; then
		use sougou && emake DESTDIR="${ED}" install_sougou_dict
		use baidu && emake DESTDIR="${ED}" install_baidu_dict
	fi

	if use rime; then
		use sougou && emake DESTDIR="${ED}" install_sougou_dict_yaml
		use baidu && emake DESTDIR="${ED}" install_baidu_dict_yaml
	fi
}
