# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

EGIT_REPO_URI="git://anongit.freedesktop.org/~jinghua/gst-plugins-pps"
inherit autotools base git

DESCRIPTION="PPStream plugin for gstreamer"
HOMEPAGE="http://cgit.freedesktop.org/~jinghua/gst-plugins-pps"
SRC_URI=""

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="media-libs/gstreamer:0.10
	media-libs/gst-plugins-base:0.10"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	AT_M4DIR="m4" eautoreconf
}
