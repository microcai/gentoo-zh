# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit gnome2

DESCRIPTION="Chinese Lunar Library Gtk+ widget"
HOMEPAGE="http://liblunar.googlecode.com"
SRC_URI="http://liblunar.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~x86 ~amd64"
IUSE="doc python"

RDEPEND="${RDEPEND}
	>=dev-libs/lunar-date-2.4.0
	doc? ( >=dev-util/gtk-doc-1 )
	python? (
		>=dev-python/pygobject-2.11.5
		>=dev-python/pygtk-2.9.7
	)
	>=x11-libs/gtk+-2.16:2
	"

DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig
	>=dev-util/intltool-0.35"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	G2CONF="$(use_enable python) $(use_enable doc)"
}
