# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="2"

inherit eutils

MY_PV="${PV/_rc/rc}"
DESCRIPTION="Takes screencast of one or more interactively selected screen
region or window"
HOMEPAGE="https://github.com/lolilolicon/FFcast2"
SRC_URI="https://github.com/downloads/lolilolicon/FFcast2/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 amd64 x86"
IUSE=""

RDEPEND="media-video/ffmpeg[x264]
	sys-devel/bc
	x11-apps/xwininfo
	x11-libs/libX11"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}"

src_install() {
#	emake DESTDIR="{D}" install || die "failed to install"
	newbin ffcast.bash ffcast || die
	dobin xrectsel || die
	dodoc README || die
}

