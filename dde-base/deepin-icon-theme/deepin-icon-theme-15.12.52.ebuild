# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit gnome2-utils

DESCRIPTION="Deepin Icons"
HOMEPAGE="https://github.com/linuxdeepin/deepin-icon-theme"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="dev-util/gtk-update-icon-cache"
#DEPEND="x11-themes/flattr-icons"

src_prepare() {
#	sed -i "s|flattr|Flattr|g" deepin/index.theme

	default_src_prepare
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }

