# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="Deepin Wallpapers"
HOMEPAGE="https://github.com/linuxdeepin/deepin-wallpapers"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dde-base/dde-api"

src_prepare() {
	LIBDIR=$(get_libdir)
	sed -i "s|/usr/lib/|/usr/${LIBDIR}/|g" Makefile || die

	default_src_prepare
}

src_install() {
		insinto /usr/share/wallpapers
		doins -r deepin

		insinto /var/cache
		doins -r image-blur
}
