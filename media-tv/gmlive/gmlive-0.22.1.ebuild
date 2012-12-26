# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit eutils

DESCRIPTION="The gtk frontend of the iptv \"mms\", \"pplive\", \"pps\" and \"sopcast\""
HOMEPAGE="http://gmlive.googlecode.com"
SRC_URI="${HOMEPAGE}/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sopcast totem extra"

# FIXME: better remove gst-plugin-libmms?
RDEPEND="dev-libs/libxml2
	>=dev-cpp/gtkmm-2.4
	totem? (
		>=media-video/totem-2.20[python]
		media-plugins/gst-plugins-libmms
	)"
DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig
	>=dev-util/intltool-0.35"
RDEPEND="${RDEPEND}
	sopcast? ( media-tv/sopcast )
	media-video/mplayer
	extra? ( media-tv/gmlive-extra )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.22-totem-plugin.patch
	sed -i \
		-e 's:channel.sopcast.com:channel.sopcast.cn:' \
		src/MainWindow.cpp || die "sed failed"
}

src_configure() {
	econf $(use_enable totem plugin)
}

src_install() {
	emake install DESTDIR="${D}" || "Install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO.tasks
}
