# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=6

inherit autotools

DESCRIPTION="Chinese Lunar Library"
HOMEPAGE="http://github.com/yetist/lunar-date"
SRC_URI="http://github.com/yetist/lunar-date/archive/v${PV}.tar.gz -> ${P}.tar.gz"

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
	doc? ( dev-util/gtk-doc )
	>=app-text/gnome-doc-utils-0.3.2"

DOCS="AUTHORS ChangeLog NEWS README"

src_prepare() {
	eapply_user
	./autogen.sh || die "autoconf failed"
}

src_configure(){
	econf $(use_enable python) $(use_enable doc) || die "compile failed"
}

src_compile(){
	emake
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
}

