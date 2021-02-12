# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="A simple audio file converter supporting many formats"
HOMEPAGE="http://www.diffingo.com"
SRC_URI="http://www.diffingo.com/downloads/audio-convert-mod/${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~x86 ~amd64"
SLOT="0"
RESTRICT="mirror"
IUSE="lame vorbis-tools musepack-tools flac faac wavpack a52dec"

RDEPEND="sys-apps/gawk
		>=sys-apps/file-4.16
		lame? ( media-sound/lame )
		vorbis-tools? ( media-sound/vorbis-tools )
		musepack-tools? ( media-sound/musepack-tools )
		flac? ( media-libs/flac )
		faac? ( media-libs/faac )
		wavpack? ( media-sound/wavpack )
		a52dec? ( media-libs/a52dec )"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
