# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit eutils waf-utils gnome2-utils

DESCRIPTION="Plugin for Thunar that adds context-menu items for Dropbox"
HOMEPAGE="http://www.softwarebakery.com/maato/thunar-dropbox.html"
SRC_URI="http://www.softwarebakery.com/maato/files/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEPEND="dev-libs/glib:2
	xfce-base/thunar
"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
"
RDEPEND="${COMMON_DEPEND}
	net-misc/dropbox
"

src_prepare() {
	epatch "${FILESDIR}/${P}-wscript.patch"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update /usr/share/icons/hicolor
	gtk-update-icon-cache
}

pkg_postrm() {
	gnome2_icon_cache_update /usr/share/icons/hicolor
	gtk-update-icon-cache
}
