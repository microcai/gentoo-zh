# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit gnome2

DESCRIPTION="Chinese Lunar Translate library"
HOMEPAGE="http://liblunar.googlecode.com"
SRC_URI="http://liblunar.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc python"

RDEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-1 )
	python? (
		>=dev-python/pygobject-2.11.5
		>=dev-python/pygtk-2.9.7
	)"

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.35
	>=app-text/gnome-doc-utils-0.3.2"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	G2CONF="$(use_enable python) $(use_enable doc)"
}
