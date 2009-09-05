# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

EGIT_REPO_URI="git://anongit.freedesktop.org/~jinghua/gst-plugins-pps"
inherit git autotools

DESCRIPTION="PPStream plugin for gstreamer"
HOMEPAGE="http://cgit.freedesktop.org/~jinghua/gst-plugins-pps"
SRC_URI=""

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="media-libs/gstreamer:0.10
	media-libs/gst-plugins-base:0.10
	media-libs/libppswrapper"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.40.0
	sys-devel/gettext"

src_prepare() {
	NOCONFIGURE=1 ./autogen.sh || die "autogen.sh failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"
}

