# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils versionator

DESCRIPTION="Ubuntu Tweak is a tool for Ubuntu that makes it easy to configure your system and desktop settings."
HOMEPAGE="http://ubuntu-tweak.com/"
SRC_URI="http://launchpad.net/${PN}/$(get_version_component_range 1-2).x/${PV}/+download/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="qt4"

RDEPEND="
	dev-lang/python
	dev-python/dbus-python
	dev-python/gconf-python
	dev-python/gnome-python-base
	dev-python/notify-python
	dev-python/pygtk
	dev-python/pyxdg
	gnome-base/gnome-desktop
	gnome-extra/polkit-gnome
	qt4? ( sys-auth/polkit-qt )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

RESTRICT="mirror"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
