# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit autotools base

DESCRIPTION="PPStream plugin for gstreamer"
HOMEPAGE="http://cgit.freedesktop.org/~jinghua/gst-plugins-pps"
SRC_URI="http://people.freedesktop.org/~jinghua/distfiles/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RESTRICT="primaryuri"

RDEPEND="
	media-libs/libppswrapper
	media-libs/gstreamer:0.10
	media-libs/gst-plugins-base:0.10"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/gettext"

src_prepare() {
	(NOCONFIGURE=1 ./autogen.sh) || die "autogen.sh failed"
}
