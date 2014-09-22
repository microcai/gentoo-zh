# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="git://github.com/lolilolicon/FFcast2.git"
	KEYWORDS=""
	RESTRICT="mirror"
	FFCAST_SRC_URI=""
	FFCAST_ECLASS="git-2"
else
	FFCAST_SRC_URI="https://github.com/lolilolicon/FFcast2/tarball/${PV} -> ${P}.tar.gz"
	RESTRICT="mirror"
	FFCAST_ECLASS="vcs-snapshot"
	KEYWORDS="~amd64 ~x86"
fi

inherit eutils ${FFCAST_ECLASS}

DESCRIPTION="Takes screencast of one or more interactively selected screen
region or window"
HOMEPAGE="https://github.com/lolilolicon/FFcast2"
SRC_URI="${FFCAST_SRC_URI}"

LICENSE="GPL-3"
SLOT="0"
IUSE="+encode vorbis vpx +x264 xvid"

RDEPEND=">=app-shells/bash-4.2_p8-r1
	|| (
		media-video/ffmpeg[encode?,vorbis?,vpx?,x264?,xvid?]
		media-video/libav[encode?,vorbis?,vpx?,x264?,xvid?]
	)
	x11-apps/xprop
	x11-apps/xdpyinfo
	x11-apps/xwininfo
	x11-libs/libX11"
DEPEND="${RDEPEND}"

src_unpack() {
	${FFCAST_ECLASS}_src_unpack
}

src_install() {
	newbin ffcast.bash ffcast || die
	dobin xrectsel || die
	newdoc README.asciidoc README || die
	doman ${PN}.1 || die
}
