# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="A fancy i3lock"
HOMEPAGE="https://github.com/meskarune/i3lock-fancy"
EGIT_REPO_URI="https://github.com/meskarune/i3lock-fancy.git"
LICENSE="BSD"
SLOT="0"

RDEPEND="app-shells/bash:0
		media-gfx/imagemagick
		app-alternatives/awk
		x11-misc/wmctrl
		media-gfx/scrot
		x11-misc/i3lock-color"

DEPEND="${RDEPEND}"

src_configure() {
	# Fix script requiring icons to be in same dir
	sed 's,$(readlink -f -- "$0"),"/usr/share/i3lock-fancy/",' lock > lock.sh
	sed -i 's/\/usr/$DESTDIR\/usr/g' Makefile
}

src_install() {
	newbin lock.sh lock

	insinto "/usr/share/i3lock-fancy"
	doins -r icons
}
