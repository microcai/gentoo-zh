# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

MY_P="${PN}-gtk2-${PV}"
DESCRIPTION="GeMan X is a branch of PCMan X."
HOMEPAGE="http://code.google.com/p/gemanx/"
SRC_URI="http://gemanx.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug iplookup libnotify mmx socks5"

RDEPEND="
	firefox? ( www-client/mozilla-firefox )
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
		$(use_enable iplookup) \
		$(use_enable libnotify) \
		$(use_enable mmx) \
		$(use_enable socks5 proxy) \
		--enable-imageview
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
}
