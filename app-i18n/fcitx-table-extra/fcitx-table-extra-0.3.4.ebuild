# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/fcitx/fcitx-table-extra.git"
	FCITX_TABLE_EXTRA_SRC_URI=""
	FCITX_TABLE_EXTRA_ECLASS="git-2"
	KEYWORDS=""
else
	FCITX_TABLE_EXTRA_SRC_URI="http://download.fcitx-im.org/${PN}/${P}.tar.xz"
	FCITX_TABLE_EXTRA_ECLASS=""
	KEYWORDS="~amd64 ~x86"
	RESTRICT="mirror"
fi

inherit cmake-utils gnome2-utils ${FCITX_TABLE_EXTRA_ECLASS}

DESCRIPTION="Extra tables for Fcitx, including Boshiamy, Zhengma, and Cangjie3, Cangjie5."
HOMEPAGE="https://github.com/fcitx/fcitx-table-extra"
SRC_URI="${FCITX_TABLE_EXTRA_SRC_URI}"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND=">=app-i18n/fcitx-4.2.8[table]"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	sys-devel/gettext"

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
