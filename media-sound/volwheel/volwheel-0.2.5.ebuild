# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Sound Volume Controller written in Perl/Gtk2"
HOMEPAGE="http://oliwer.net/b/volwheel.html"
SRC_URI="http://olwtools.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE="alsa"

DEPEND=""
RDEPEND="dev-lang/perl
	dev-perl/gtk2-perl
	dev-perl/gtk2-trayicon
	alsa? ( media-sound/alsa-utils )"

src_install() {
	exeinto /usr/bin
	doexe volwheel

	# dosed only works in ${D}
	dosed "s:volwheel/icons:pixmaps/volwheel:g" /usr/bin/volwheel \
		|| die "dosed failed"

	insinto /usr/share/pixmaps/${PN}
	doins -r icons/*
	make_desktop_entry ${PN} "VolWheel" "volwheel/${PN}.png" "Audio;Mixer"

	dodoc ChangeLog README
}
