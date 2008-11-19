# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="The gtk frontend of the iptv \"mms\" and \"sopcast\""
HOMEPAGE="http://gmlive.googlecode.com"
SRC_URI="http://gmlive.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sopcast totem"

RDEPEND="dev-libs/libxml2
	>=dev-cpp/libglademm-2.4
	>=dev-cpp/gtkmm-2.4
	>=dev-cpp/glibmm-2.6
	totem? ( media-video/totem )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/pkgconfig-0.19
	>=dev-util/intltool-0.35"
RDEPEND="${RDEPEND}
	media-plugins/gst-plugins-libmms
	media-video/mplayer
	sopcast? ( media-tv/sopcast )"

RESTRICT="primaryuri"

src_compile() {
	econf $(use_enable totem plugin)
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || "Install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO.tasks
}
