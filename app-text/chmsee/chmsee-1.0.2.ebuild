# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit gnome2

DESCRIPTION="HTML Help viewer for Unix/Linux"
HOMEPAGE="http://chmsee.googlecode.com"
SRC_URI="http://chmsee.googlecode.com/files/chmsee-1.0.2.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="xulrunner debug"

# FIXME:
RDEPEND=">=gnome-base/libglade-2.4
	>=x11-libs/gtk+-2.8
	dev-libs/chmlib
	dev-libs/libgcrypt
	xulrunner? ( || ( =net-libs/xulrunner-1.9* =net-libs/xulrunner-1.8* ) )
	!xulrunner? ( >=www-client/mozilla-firefox-1.5.0.7 )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

DOCS="AUTHORS NEWS README TODO"

src_compile() {
	if use xulrunner ; then
		if has_version '=net-libs/xulrunner-1.9*' ; then
			G2CONF="${G2CONF} --with-gecko=libxul"
		else
			G2CONF="${G2CONF} --with-gecko=xulrunner"
		fi
	else
		G2CONF="${G2CONF} --with-gecko=firefox"
	fi

	gnome2_src_compile
}

src_install() {
	gnome2_src_install
	rm -rf  "${D}/var/"
}
