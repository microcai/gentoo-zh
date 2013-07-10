# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

DESCRIPTION="A gtk based configure tool for fcitx."
HOMEPAGE="https://github.com/fcitx/fcitx-configtool"
SRC_URI="http://download.fcitx-im.org/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk +gtk3"
REQUIRED_USE="|| ( gtk gtk3 )"
RESTRICT="mirror"

RDEPEND=">=app-i18n/fcitx-4.2.8
	dev-libs/glib:2
	gtk? ( x11-libs/gtk+:2 )
	gtk3? ( x11-libs/gtk+:3 )"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	app-text/iso-codes
	gtk? (
		dev-libs/dbus-glib
		dev-libs/libunique:1
	)
	virtual/pkgconfig
	sys-devel/gettext"

src_configure() {
	local mycmakeargs="
		$(cmake-utils_use_enable gtk GTK2)
		$(cmake-utils_use_enable gtk3 GTK3)"
	cmake-utils_src_configure
}

pkg_postinst() {
	if use gtk; then
		ewarn "You has built the gtk2 version of the configtool."
		ewarn "It is strongly encouraged by upstream to use the gtk3 version."
	fi
}
