# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="Base components for Deepin Desktop"
HOMEPAGE="https://github.com/linuxdeepin/deepin-desktop-base"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dde-base/deepin-wallpapers
		dde-base/deepin-artwork-themes
		dde-base/deepin-icon-theme
		dde-base/deepin-gtk-theme
		dde-base/deepin-sound-theme"

src_prepare() {
	LIBDIR=$(get_libdir)
	sed -i "s|/usr/lib/|/usr/${LIBDIR}/|g" Makefile
	default_src_prepare
}

src_install() {
	emake DESTDIR=${D} install

	rm -r ${D}/etc/lsb-release ${D}/etc/systemd ${D}/usr/share/python-apt

	dosym /usr/$(get_libdir)/deepin/desktop-version /etc/deepin-version
}
