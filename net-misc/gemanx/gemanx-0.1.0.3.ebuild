# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MY_P="${PN}-gtk2-${PV}"
DESCRIPTION="GeMan X is a branch of PCMan X."
HOMEPAGE="http://code.google.com/p/gemanx/"
SRC_URI="http://gemanx.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug +imageview iplookup libnotify mmx socks5"

RDEPEND="
	imageview? (
		net-misc/curl
		sys-apps/file )
	>=x11-libs/gtk+-2.4
	libnotify? ( x11-libs/libnotify )
	x11-libs/libXft"
DEPEND="${RDEPEND}
	dev-util/intltool"

S=${WORKDIR}/${MY_P}
RESTRICT="primaryuri"

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_enable imageview) \
		$(use_enable iplookup) \
		$(use_enable libnotify) \
		$(use_enable mmx) \
		$(use_enable socks5 proxy)
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
}
