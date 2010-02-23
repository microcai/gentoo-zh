# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit bzr

EBZR_REPO_URI="lp:~tualatrix/+junk/elementary-mod-theme"

DESCRIPTION="Elementary-mod theme for GNOME"
HOMEPAGE="https://code.launchpad.net/~tualatrix/+junk/elementary-mod-theme"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~mips ~ppc ~sh ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="
	x11-themes/dmz-cursor-theme
	x11-themes/elementary-icon-theme
	x11-themes/gtk-engines-aurora
	x11-themes/gtk-engines-murrine"

RESTRICT="binchecks strip"

src_install() {
	insinto /usr/share/themes
	doins -r elementary-mod
}
