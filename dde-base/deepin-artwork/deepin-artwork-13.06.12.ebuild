# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Deepin themes, icons, and sounds"
HOMEPAGE="http://www.linuxdeepin.com"
SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/d/${PN}/${PN}_${PV}.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="media-fonts/wqy-microhei
		media-fonts/liberation-fonts
		x11-themes/gtk-engines-unico
		x11-themes/dmz-cursor-theme
		x11-themes/faenza-icon-theme"

src_install() {
	insinto "/"
	doins -r ${S}/etc ${S}/usr

	rm -r ${D}/etc/X11

}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }

