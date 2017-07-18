# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=4
inherit gnome2-utils

DESCRIPTION="GSettings deepin desktop-wide schemas"
HOMEPAGE="https://github.com/linuxdeepin/deepin-desktop-schemas"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="gnome-base/dconf"


#src_compile() {
#	emake ARCH=x86
#}
pkg_preinst() { gnome2_schemas_savelist;}
pkg_postinst() { gnome2_schemas_update; }
pkg_postrm() { gnome2_schemas_update; }
