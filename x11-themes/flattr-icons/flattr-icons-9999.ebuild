# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit gnome2-utils git-r3

DESCRIPTION="an icon theme inspired by the latest flat design trend"
HOMEPAGE="https://github.com/NitruxSA/flattr-icons"
EGIT_REPO_URI="https://github.com/NitruxSA/${PN}.git"

LICENSE="CC-BY-NC-SA-4.0"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="x11-themes/hicolor-icon-theme"

RESTRICT="binchecks strip"

src_install() {
	insinto /usr/share/icons/flattr
	doins -r *
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
