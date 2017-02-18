# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit git-r3 gnome2 autotools flag-o-matic

DESCRIPTION="Screencasting program that saves casts as GIF files"
HOMEPAGE="https://git.gnome.org/browse/byzanz/"
#SRC_URI="https://git.gnome.org/browse/byzanz/snapshot/byzanz-master.tar.xz -> ${P}.tar.xz"
SRC_URI=""
EGIT_REPO_URI="https://git.gnome.org/browse/byzanz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/libXdamage-1.0
	>=dev-libs/glib-2.16:2
	x11-libs/gtk+:3
	media-libs/gst-plugins-base
	media-libs/gst-plugins-good
	>=x11-libs/cairo-1.8.10"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-util/intltool
	>=x11-proto/damageproto-1.0"

DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README"

src_prepare() {
	eautoreconf
	gnome2_src_prepare
	append-flags " -Wno-error"
}
