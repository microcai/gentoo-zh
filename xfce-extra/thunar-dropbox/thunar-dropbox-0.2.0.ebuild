# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
PYTHON_DEPEND="2:2.6"

inherit gnome2-utils multilib python waf-utils

DESCRIPTION="Plugin for thunar that adds context-menu items for dropbox."
HOMEPAGE="http://www.softwarebakery.com/maato/thunar-dropbox.html"
SRC_URI="http://www.softwarebakery.com/maato/files/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-misc/dropbox
>=xfce-base/thunar-1.2"
DEPEND="${RDEPEND}
virtual/pkgconfig"

DOCS=( AUTHORS ChangeLog )

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	sed -e "s:gtk-update-icon-cache.*:/bin/true':" \
		-e "s:/lib/:/$(get_libdir)/:" -i wscript || die "sed failed"
}

pkg_preinst() { 
	gnome2_icon_savelist; 
}

pkg_postinst() { 
	gnome2_icon_cache_update /usr/share/icons/hicolor; 
	ewarn
	ewarn "thunar-dropbox does work when dropbox is running."
	ewarn
}

pkg_postrm() { 
	gnome2_icon_cache_update /usr/share/icons/hicolor; 
}
