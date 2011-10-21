# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="2"

inherit eutils git-2

EGIT_REPO_URI="git://github.com/lolilolicon/FFcast2.git"

DESCRIPTION="Takes screencast of one or more interactively selected screen
region or window"
HOMEPAGE="http://github.com/lolilolicon/FFcast2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="media-video/ffmpeg[x264]
	x11-apps/xwininfo
	x11-libs/libX11"
DEPEND="${RDEPEND}"

src_install() {
	emake DESTDIR="{D}" install || die "failed to install"
#	newbin ffcast.bash ffcast || die
#	dobin xrectsel || die
#	dodoc README || die
}

