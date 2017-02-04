# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Iptux is a ipmsg client in linux"
HOMEPAGE="https://github.com/iptux-src/iptux"

SRC_URI="https://github.com/iptux-src/iptux/archive/v${PV}.zip -> ${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="
	gnome-base/gconf
	>=x11-libs/gtk+-2.22"
RDEPEND="${DEPEND}"

src_configure() {
	econf
}
src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
}
