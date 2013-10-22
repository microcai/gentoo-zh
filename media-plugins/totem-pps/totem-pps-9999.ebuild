# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit autotools base git-2

EGIT_REPO_URI="git://anongit.freedesktop.org/~jinghua/totem-pps"

DESCRIPTION="PPStream browser for totem"
HOMEPAGE="http://cgit.freedesktop.org/~jinghua/totem-pps"
SRC_URI=""

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-python/beautifulsoup
	media-plugins/gst-plugins-pps
	media-video/totem[python]"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40.0
	sys-devel/gettext"

src_prepare() {
	eautoreconf
}
