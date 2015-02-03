# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit linux-info xorg-2

DESCRIPTION="Xorg driver that use libinput"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=">=x11-base/xorg-server-1.16[udev]
	dev-libs/libevdev
	sys-libs/mtdev"
DEPEND="${RDEPEND}
	>=x11-proto/inputproto-2.1.99.3
	>=dev-libs/libinput-0.8.0
	>=sys-kernel/linux-headers-3.10"

pkg_pretend() {
	if use kernel_linux ; then
		CONFIG_CHECK="~INPUT_EVDEV"
	fi
	check_extra_config
}

src_install(){
  xorg-2_src_install
  install -m755 -d "${D}/usr/share/X11/xorg.conf.d"
  install -m644 conf/99-libinput.conf "${D}/usr/share/X11/xorg.conf.d/"
}
