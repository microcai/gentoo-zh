# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

HOMEPAGE="http://libqq-pidgin.googlecode.com"

inherit autotools googlecode subversion

DESCRIPTION="Pidgin QQ2010 PlugIn"

ESVN_REPO_URI="${HOMEPAGE}/svn/trunk/"

SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

ESVN_REVISION="r${PV}"

RDEPEND="
	|| ( >=net-im/pidgin-2.7.11[-qq]  >=net-im/pidgin-2.8.0 )
	x11-libs/gtk+:2
	>=dev-libs/nss-3.11"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
#	./autogen.sh || die "autogen.sh failed"
	mkdir -pv ${S}/m4
	eautoreconf
}
