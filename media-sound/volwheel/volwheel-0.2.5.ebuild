# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

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

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e \
		"s:volwheel/icons:pixmaps/volwheel:g" volwheel \
		|| die "sed failed"
}

src_install() {
	exeinto /usr/bin
	doexe volwheel
	insinto /usr/share/pixmaps/volwheel
	doins -r icons/*

	dodoc ChangeLog README
}
