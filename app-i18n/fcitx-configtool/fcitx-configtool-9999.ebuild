# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit cmake-utils

DESCRIPTION="A GTK+ GUI configuration tool for fcitx"
HOMEPAGE="http://fcitx-im.org/"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/fcitx/${PN}.git"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="http://download.fcitx-im.org/${PN}/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="gtk +gtk3"
REQUIRED_USE="|| ( gtk gtk3 )"

RDEPEND=">=app-i18n/fcitx-4.2.8
	dev-libs/glib:2
	gtk? ( x11-libs/gtk+:2 )
	gtk3? ( x11-libs/gtk+:3	)"
DEPEND="${RDEPEND}
	app-text/iso-codes
	dev-libs/libunique:1
	dev-util/intltool
	virtual/pkgconfig"

src_configure() {
	local mycmakeargs="
		$(cmake-utils_use_enable gtk GTK2)
		$(cmake-utils_use_enable gtk3 GTK3)"

	cmake-utils_src_configure
}
