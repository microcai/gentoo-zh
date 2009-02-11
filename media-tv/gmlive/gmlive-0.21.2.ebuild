# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="The gtk frontend of the iptv \"mms\" and \"sopcast\""
HOMEPAGE="http://gmlive.googlecode.com"
SRC_URI="${HOMEPAGE}/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sopcast totem"

RDEPEND="dev-libs/libxml2
	>=dev-cpp/libglademm-2.4
	>=dev-cpp/gtkmm-2.4
	totem? ( >=media-video/totem-2.20[python] )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/pkgconfig-0.19
	>=dev-util/intltool-0.35"
RDEPEND="${RDEPEND}
	sopcast? ( media-tv/sopcast )
	media-plugins/gst-plugins-libmms
	media-video/mplayer"

src_prepare() {
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
