# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Chinese fortune shell script"
HOMEPAGE="http://code.google.com/p/chinese-fortune"
SRC_URI="http://chinese-fortune.googlecode.com/files/${P}.tar.bz2"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86"
IUSE="gnome"

RDEPEND="games-misc/fortune-mod
	app-i18n/zh-autoconvert
	gnome? ( >=gnome-extra/zenity-2.10.1 )"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	if use zenity ; then
		exeinto /usr/bin
		doexe gfortune-zh
	fi
}
