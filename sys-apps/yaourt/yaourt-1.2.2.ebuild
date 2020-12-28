# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit bash-completion-r1 eutils

DESCRIPTION="A pacman wrapper with extended features and AUR support"
HOMEPAGE="http://www.archlinux.fr/yaourt-en/"
SRC_URI="http://mir.archlinux.fr/~tuxce/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	>=sys-apps/package-query-1.0
	>=sys-apps/pacman-4.0
"

RDEPEND="${DEPEND}"

src_prepare() {
	emake PREFIX=/usr sysconfdir=/etc localstatedir=/var
}

src_install() {
	emake PREFIX=/usr sysconfdir=/etc localstatedir=/var DESTDIR="${D}" install
	sed -i /_completion_loader/d bashcompletion
	newbashcomp bashcompletion yaourt
}
