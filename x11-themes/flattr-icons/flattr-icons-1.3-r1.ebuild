# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit gnome2-utils

DESCRIPTION="an icon theme inspired by the latest flat design trend"
HOMEPAGE="https://github.com/NitruxSA/flattr-icons"
SRC_URI="https://github.com/NitruxSA/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="CC-BY-NC-SA-4.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="x11-themes/hicolor-icon-theme"

RESTRICT="binchecks strip"

S=${WORKDIR}/luv-icon-theme-${PV}

src_install() {
	insinto /usr/share/icons/
	doins -r Flattr*
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
