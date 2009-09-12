# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit autotools versionator

MY_PN="${PN/-/}"
DESCRIPTION="An OSD lyric show supporting multiple media players and downloading."
HOMEPAGE="http://code.google.com/p/osd-lyrics/"
SRC_URI="http://osd-lyrics.googlecode.com/files/${MY_PN}-${PVR/-r/-}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-libs/dbus-glib
	gnome-base/libglade
	net-misc/curl
	x11-libs/gtk+"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_PN}-$(get_version_component_range 1-2)

src_prepare() {
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS ChangeLog NEWS* README*
}
