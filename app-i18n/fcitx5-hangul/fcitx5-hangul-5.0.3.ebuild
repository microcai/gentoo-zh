# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI="7"

inherit cmake xdg-utils

if [[ "${PV}" =~ (^|\.)9999$ ]]; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/fcitx/fcitx5-hangul"
fi

DESCRIPTION="Korean Hangul input method for Fcitx"
HOMEPAGE="https://fcitx-im.org/ https://github.com/fcitx/fcitx5-hangul"
if [[ "${PV}" =~ (^|\.)9999$ ]]; then
	SRC_URI=""
else
	SRC_URI="https://download.fcitx-im.org/fcitx5/${PN}/${P}.tar.xz"
fi

LICENSE="GPL-2+"
SLOT="5"
KEYWORDS="~amd64"
IUSE=""

BDEPEND="sys-devel/gettext
	virtual/pkgconfig"
DEPEND=">=app-i18n/fcitx5-5.0.2:5
	>=app-i18n/libhangul-0.0.12
	virtual/libiconv
	virtual/libintl
	!app-i18n/fcitx-hangul"
RDEPEND="${DEPEND}"

DOCS=(AUTHORS)

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
