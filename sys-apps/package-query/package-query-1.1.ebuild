# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit autotools autotools-utils eutils

DESCRIPTION="Query ALPM and AUR"
HOMEPAGE="http://gitweb.archlinux.fr/package-query.git/"
SRC_URI="http://mir.archlinux.fr/~tuxce/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-libs/yajl
	>=sys-apps/pacman-4.0
	<=sys-apps/pacman-4.1
"

RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		--prefix=/usr
		--sysconfdir=/etc
		--localstatedir=/var
		--with-aur-url=https://aur.archlinux.org
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
}
