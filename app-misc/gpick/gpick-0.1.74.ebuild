# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Advanced color picker written in C++ using GTK+ toolkit"
HOMEPAGE="http://code.google.com/p/gpick/"
SRC_URI="http://gpick.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-util/scons"
RDEPEND="
	>=dev-lang/lua-5.1
	>=x11-libs/gtk+-2.12
	|| ( >=dev-libs/dbus-glib-0.76 dev-libs/libunique )"

QA_PRESTRIPPED="usr/bin/gpick"

src_install() {
	dodir /usr
	scons install DESTDIR="${D}"/usr || die "install failed"
}
