# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils gnome2-utils

DESCRIPTION="unikey support for fcitx."
HOMEPAGE="https://github.com/fcitx/fcitx-unikey"
SRC_URI="http://download.fcitx-im.org/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+qt4"
RESTRICT="mirror"

RDEPEND=">=app-i18n/fcitx-4.2.8"
DEPEND="app-arch/xz-utils
	sys-devel/gettext"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable qt4 QT)
	)

	cmake-utils_src_configure
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
