# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils linux-info

DESCRIPTION="fast FrameBuffer based TERMinal emulator for Linux"
HOMEPAGE="http://fbterm.googlecode.com"
SRC_URI="http://fbterm.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="media-libs/fontconfig
	>=media-libs/freetype-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_config() {
	# FIXME
	if !(linux_chkconfig_present CONFIG_FB); then
		eerror "You don't have framebuffer support, please check your kernel configuration!"
		die "You don't have framebuffer support, please check your kernel configuration!"
	fi
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"
	dodoc AUTHORS NEWS README
}

pkg_postinst() {
	echo
	elog "To use ${PN}, ensure you are in video group."
	echo
}
