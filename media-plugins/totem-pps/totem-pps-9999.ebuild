# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

EGIT_REPO_URI="git://anongit.freedesktop.org/~jinghua/totem-pps"
inherit autotools base git

DESCRIPTION="PPStream browser for totem"
HOMEPAGE="http://cgit.freedesktop.org/~jinghua/totem-pps"
SRC_URI=""

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="media-video/totem[python]"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40.0
	sys-devel/gettext"

src_prepare() {
	eautoreconf
}
