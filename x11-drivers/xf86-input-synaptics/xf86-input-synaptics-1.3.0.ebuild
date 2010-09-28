# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-input-synaptics/xf86-input-synaptics-1.3.0.ebuild,v 1.2 2010/09/10 13:27:03 chithanh Exp $

EAPI=3

inherit linux-info xorg-2

DESCRIPTION="Driver for Synaptics touchpads"
HOMEPAGE="http://cgit.freedesktop.org/xorg/driver/xf86-input-synaptics/"

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="
	>=x11-base/xorg-server-1.8
	>=x11-libs/libXi-1.2
	>=x11-libs/libXtst-1.1.0"
DEPEND="${RDEPEND}
	x11-proto/inputproto
	>=x11-proto/recordproto-1.14"

src_prepare() {
	x-modular_src_prepare
	epatch "${FILESDIR}/${P}-clickpad.patch" || die "epatch fail!"
}

src_install() {
	DOCS="README" xorg-2_src_install
}
pkg_postinst() {
	xorg-2_pkg_postinst
	# Just a friendly warning
	if ! linux_config_exists \
			|| ! linux_chkconfig_present INPUT_EVDEV; then
		echo
		ewarn "This driver requires event interface support in your kernel"
		ewarn "  Device Drivers --->"
		ewarn "    Input device support --->"
		ewarn "      <*>     Event interface"
		echo
	fi
}
