# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $


inherit autotools git-r3

DESCRIPTION="mp3/ogg/flac/sid/mod/nsf music player based on GTK2"
HOMEPAGE="http://deadbeef.sourceforge.net/"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="media-libs/libvorbis
	   media-libs/libmad
	   media-libs/libogg
	   x11-libs/gtk+
	   media-libs/libsamplerate
	   media-libs/alsa-lib"
DEPEND=""

src_unpack() {
	git_src_unpack || die "Git synchronization failed"
}

src_compile() {
	./autogen.sh || die "Autogen.sh faild"
	econf || die "Configure failed"
	emake || die "Make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
}
