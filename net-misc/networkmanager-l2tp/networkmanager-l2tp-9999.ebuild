# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit eutils gnome.org git-2 autotools

# NetworkManager likes itself with capital letters
MY_PN="${PN/networkmanager/NetworkManager}"

DESCRIPTION="NetworkManager L2TP plugin"
HOMEPAGE="http://www.gnome.org/projects/NetworkManager/"
#SRC_URI="${SRC_URI//${PN}/${MY_PN}}"
SRC_URI=""

EGIT_REPO_URI="git://github.com/microcai/NetworkManager-l2tp.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome"

RDEPEND="
	>=net-misc/networkmanager-0.8.1
	>=dev-libs/dbus-glib-0.74
	net-dialup/ppp
	net-dialup/xl2tpd
	gnome? (
		>=x11-libs/gtk+-2.6:2
		gnome-base/gconf:2
		gnome-base/gnome-keyring
		gnome-base/libglade:2.0
	)"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/intltool
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_PN}-${PV}"

src_prepare() {
	mkdir -p m4
	intltoolize --copy --force --automake
	eautoreconf
}

src_configure() {
	ECONF="--with-pppd-plugin-dir=/usr/lib/pppd/2.4.5
		$(use_with gnome)"

	econf ${ECONF}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog NEWS README || die "dodoc failed"
}
