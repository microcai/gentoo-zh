# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
inherit eutils autotools

DESCRIPTION="The gtk frontend of the iptv \"mms\", \"pplive\", \"pps\" and \"sopcast\""
HOMEPAGE="http://gmlive.googlecode.com"
SRC_URI="${HOMEPAGE}/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="extra"

# FIXME: better remove gst-plugin-libmms?
RDEPEND=">=dev-libs/libxml2-2.6
	dev-cpp/gtkmm:2.4
"
DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig
	>=dev-util/intltool-0.35"
RDEPEND="${RDEPEND}
	media-video/mplayer"

PDEPEND="extra? ( media-tv/gmlive-extra )"

src_prepare() {
	sed -i \
		-e 's:channel.sopcast.com:channel.sopcast.cn:' \
		src/MainWindow.cpp || die "sed failed"
}

src_install() {
	emake install DESTDIR="${D}" || "Install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO.tasks
}

pkg_postinst(){
	einfo "${PN} have change it's configuration files from ~/.gmlive to ~/.config/gmlive."
	einfo "please consider mv origianl configuration files"
}
