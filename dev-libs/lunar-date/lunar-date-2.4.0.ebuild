# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=4

inherit autotools

DESCRIPTION="Chinese Lunar Library"
HOMEPAGE="http://liblunar.googlecode.com"
SRC_URI="http://liblunar.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="doc python"

RDEPEND="${RDEPEND}
	python? ( >=dev-python/pygobject-2.11.5 )"

DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig
	>=dev-util/intltool-0.35
	dev-util/gtk-doc
	>=app-text/gnome-doc-utils-0.3.2"

DOCS="AUTHORS ChangeLog NEWS README"

src_compile() {
	econf $(use_enable python) $(use_enable doc) || die "compile failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
}
