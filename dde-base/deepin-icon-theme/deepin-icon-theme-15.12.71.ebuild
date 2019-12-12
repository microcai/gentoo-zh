# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7
inherit gnome2-utils

DESCRIPTION="Deepin Icons"
HOMEPAGE="https://github.com/linuxdeepin/deepin-icon-theme"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="dev-util/gtk-update-icon-cache"

src_prepare() {

	default_src_prepare
}

src_compile() {
	emake hicolor-links
}

src_install() {
	emake DESTDIR="$D" install-icons install-cursors
	insinto /usr/share/icons/
	doins -r Sea usr/share/icons/hicolor
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }

