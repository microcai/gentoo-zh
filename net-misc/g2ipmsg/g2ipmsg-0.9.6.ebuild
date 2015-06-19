# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit gnome2

DESCRIPTION="IP messenger clone for GNOME2 environments"
HOMEPAGE="http://www.ipmsg.org/index.html.en"
SRC_URI="http://www.ipmsg.org/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="gnome linguas_zh_CN ssl" #doc
KEYWORDS="~x86 ~amd64"

RDEPEND=">=dev-libs/glib-2.8
	ssl? ( dev-libs/openssl )
	gnome-base/libgnomeui
	>=x11-libs/gtk+-2.10
	gnome? (
		dev-libs/dbus-glib
		>=gnome-base/gnome-panel-2
	)
	virtual/libiconv"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig"
#doc? ( app-doc/doxygen )

RESTRICT="primaryuri"

pkg_setup() {
	DOCS="AUTHORS ChangeLog README"

	# Everyone needs systray+utf8?
	G2CONF="--enable-utf-8 --enable-systray \
		--disable-dependency-tracking"

	G2CONF="${G2CONF} $(use_with ssl) \
		$(use_enable gnome applet) \
		$(use_enable gnome dbus-glib) \
		$(use_enable gnome gnome-screensaver) \
		$(use_enable gnome schemas-install) \
		$(use_with linguas_zh_CN ext-charcode CP936)"
}

src_unpack() {
	gnome2_src_unpack

	# Fix external charset encoding. (thanks goes to kingbo@linuxsir)
	# http://linuxsir.org/bbs/post1926325.html
	sed -i -e '10926d' configure
	use linguas_zh_CN && \
		sed -i -e 's:CP932:CP936:' g2ipmsg.schemas.in
}

src_install() {
	gnome2_src_install
	if ! use gnome ; then
		rm -rf "${D}"/usr/lib
	fi
}
