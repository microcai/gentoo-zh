# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="The gtk front-end of the iptv \"mms\" and \"sopcast\" and \"nslive\""
HOMEPAGE="http://gmlive.googlecode.com"
SRC_URI="http://gmlive.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sopcast nslive totem"
RESTRICT="mirror"

RDEPEND=">=dev-libs/glib-2.6
		 >=dev-libs/openssl-0.9.8
		 >=x11-libs/gtk+-2.6
		 >=dev-cpp/libglademm-2.4
		 >=dev-cpp/gtkmm-2.4
		 >=dev-cpp/glibmm-2
		 media-video/mplayer
		 sopcast? ( media-tv/sopcast )
		 nslive? ( media-tv/nslive )
		 totem? ( media-video/totem )"
DEPEND="${RDEPEND}
		sys-devel/gettext
		>=dev-util/pkgconfig-0.19
		>=dev-util/intltool-0.35"

src_compile() {
	econf $(use_enable totem plugin) || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
}

pkg_postinst() {
	if use nslive; then
		ewarn "Note: please execute the program \"nslive -p 33\" to initialize "
		ewarn "      nslive. and comment the line \"mplayer=/usr/bin/mplayer\""
		ewarn "      in the configure file \"\${HOME}/.ulive/ulive.conf\""
	fi
}
