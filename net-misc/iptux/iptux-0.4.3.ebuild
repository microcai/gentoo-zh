# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Iptux is a ipmsg client in linux"
HOMEPAGE="http://code.google.com/p/iptux/"
SRC_URI="http://iptux.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="gnome-base/gconf
		>=x11-libs/gtk+-2.10.14"

RDEPEND="${DEPEND}"

RESTRICT="mirror"  #for overlay


src_install() {
	einstall || "einstall failed"
}
