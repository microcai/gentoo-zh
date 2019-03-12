# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils gnome.org git-2 autotools

# NetworkManager likes itself with capital letters
MY_PN="${PN/networkmanager/NetworkManager}"

DESCRIPTION="NetworkManager L2TP plugin"
HOMEPAGE="http://www.gnome.org/projects/NetworkManager/"
#SRC_URI="${SRC_URI//${PN}/${MY_PN}}"
SRC_URI=""

EGIT_REPO_URI="https://github.com/microcai/NetworkManager-l2tp.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome"

RDEPEND="
	>=net-misc/networkmanager-1.0[ppp]
	dev-libs/dbus-glib
	net-dialup/ppp
	net-dialup/xl2tpd
	>=dev-libs/glib-2.32
	gnome? (
		>=x11-libs/gtk+-3.4:4
		gnome-base/libgnome-keyring
	)"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/intltool
	virtual/pkgconfig"

S="${WORKDIR}/${MY_PN}-${PV}"

src_prepare() {
	mkdir -p m4
	intltoolize --copy --force --automake
	eautoreconf
}

src_configure() {
	ECONF="--with-pppd-plugin-dir=/usr/lib/pppd/2.4.7
		$(use_with gnome)"

	econf ${ECONF}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog NEWS README || die "dodoc failed"
}
