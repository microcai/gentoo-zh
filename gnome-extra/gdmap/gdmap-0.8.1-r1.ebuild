# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit gnome2 eutils

DESCRIPTION="GTK+ disk space visualizer"
HOMEPAGE="http://gdmap.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="doc"
SLOT="0"

RDEPEND=">=x11-libs/gtk+-2.6.0
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"
DOCS="ChangeLog README NEWS AUTHORS"

src_prepare() {
	gnome2_src_prepare
	epatch "${FILESDIR}"/02_gtk_disable_deprecated_minimal.dpatch
}
