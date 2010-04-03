# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit gnome2-utils

DESCRIPTION="GNOME themes from Ubuntu"
HOMEPAGE="http://www.ubuntu.com"
SRC_URI="mirror://ubuntu/pool/main/h/${PN}/${PN}_${PV}.tar.gz"

LICENSE="CCPL-Attribution-ShareAlike-2.5"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	x11-themes/humanity-icon-theme
	x11-themes/dmz-cursor-theme
	x11-themes/gtk-engines-murrine
	x11-themes/humanity-icon-theme"
DEPEND=""

RESTRICT="binchecks mirror strip"

src_compile() {
	for theme_dir in "." "DarkRoom" "Human-Clearlooks"; do
		mv ${theme_dir}/index.theme{.in,} || die
		sed -i -e "s|^_||g" ${theme_dir}/index.theme || die
		sed -i -r "s/(CursorTheme=)(default|Human)/\1DMZ-White/g" \
			${theme_dir}/index.theme || die
	done
}

src_install() {
	insinto /usr/share/themes
	doins -r DarkRoom Human Human-Clearlooks HumanLogin || die

	insinto /usr/share/themes/Human
	doins cursor.theme
	doins index.theme

	insinto /usr/share/themes/Human/metacity-1
	doins metacity/Human/* || die

	insinto /usr/share/icons
	doins -r HumanLoginIcons || die

	dodoc AUTHORS debian/{changelog,copyright} NEWS README || die "install doc failed."
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
