# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="A fancy i3lock"
HOMEPAGE="https://github.com/meskarune/i3lock-fancy"
EGIT_REPO_URI="https://github.com/meskarune/i3lock-fancy.git"
LICENSE="BSD"
SRC_URI=""
KEYWORDS="~amd64"
SLOT="0"

RDEPEND="app-shells/bash:0
		media-gfx/imagemagick
		virtual/awk
		x11-misc/wmctrl
		media-gfx/scrot
		x11-misc/i3lock-color"

DEPEND="${RDEPEND}"

INST_DIR="${D}/usr/share/i3lock-fancy"

src_configure() {
	# Fix script requiring icons to be in same dir
	sed 's,$(readlink -f -- "$0"),"/usr/share/i3lock-fancy/",' lock > lock.sh
	sed -i 's/\/usr/$DESTDIR\/usr/g' Makefile
}

src_install() {
	mkdir -p "$INST_DIR" "${D%/*}/usr/bin/"
	cp lock.sh "${D}/usr/bin/lock"
	chmod +x "${D}/usr/bin/lock"
	cp -r icons "${INST_DIR}"
}

