# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit subversion

DESCRIPTION="GeMan X is a branch of PCMan X."
HOMEPAGE="http://code.google.com/p/gemanx/"
ESVN_REPO_URI="http://gemanx.googlecode.com/svn/trunk/"
ESVN_BOOTSTRAP="autogen.sh"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
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
