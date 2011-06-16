# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-qq/pidgin-qq-9999.ebuild $

EAPI="3"

HOMEPAGE="http://libqq-pidgin.googlecode.com"

inherit autotools googlecode

DESCRIPTION="Pidgin QQ2010 PlugIn"

SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	|| ( >=net-im/pidgin-2.7.11[-qq]  >=net-im/pidgin-2.8.0 )
	x11-libs/gtk+:2
	>=dev-libs/nss-3.11"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
#	./autogen.sh || die "autogen.sh failed"
	eautoreconf
}
