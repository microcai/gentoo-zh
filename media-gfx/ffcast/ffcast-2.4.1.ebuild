# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools

MY_PN="FFcast"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="FFcast has almost nothing to do with FFmpeg or screencast ;)"
HOMEPAGE="https://github.com/lolilolicon/FFcast"
SRC_URI="https://github.com/lolilolicon/${MY_PN}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="zsh-completion"

RESTRICT="mirror"

DEPEND=""
RDEPEND="${DEPEND}
	>=app-shells/bash-4.3
	|| ( media-video/ffmpeg media-video/libav )
	x11-apps/xdpyinfo
	x11-apps/xprop
	x11-apps/xwininfo
	media-gfx/xrectsel
	zsh-completion? ( app-shells/zsh-completion )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	rmdir "src/xrectsel" || die "rmdir failed"
	eautoreconf
}

src_configure() {
	econf \
		--disable-xrectsel \
		$(use_enable zsh-completion )
}
