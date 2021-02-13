# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 gnome2 autotools flag-o-matic

DESCRIPTION="Screencasting program that saves casts as GIF files"
HOMEPAGE="https://gitlab.gnome.org/Archive/byzanz/"
#SRC_URI="https://gitlab.gnome.org/Archive/byzanz/-/archive/master/byzanz-master.tar.gz -> ${P}.tar.gz"
SRC_URI=""
EGIT_REPO_URI="https://gitlab.gnome.org/Archive/byzanz.git"

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
	x11-base/xorg-proto
	"

DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README"

src_prepare() {
	eautoreconf
	gnome2_src_prepare
	append-flags " -Wno-error"
}
