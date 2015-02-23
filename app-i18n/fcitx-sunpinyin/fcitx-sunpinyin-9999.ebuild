# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils gnome2-utils

DESCRIPTION="Sunpinyin module for fcitx"
HOMEPAGE="http://fcitx-im.org/"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/fcitx/${PN}"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="http://download.fcitx-im.org/${PN}/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="data"

RDEPEND=">=app-i18n/fcitx-4.2.8
	>app-i18n/sunpinyin-2.0.3
	data? ( app-i18n/sunpinyin-data )"
DEPEND="${RDEPEND}
	virtual/libintl"

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
