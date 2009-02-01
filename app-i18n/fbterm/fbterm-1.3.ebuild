# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils linux-info

DESCRIPTION="fast FrameBuffer based TERMinal emulator for Linux"
HOMEPAGE="http://fbterm.googlecode.com"
SRC_URI="http://fbterm.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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
	# Copied from debian patch
	einfo
	elog "${PN} won't work with vga16fb. You have to use other native"
	elog "framebuffer drivers or vesa driver."
	elog "See /usr/share/doc/${PVR}/README for details."
	elog "To use ${PN}, ensure You are in video group."
	elog "To input Chinese merge \"app-i18n/fbterm-ucimf\" in gentoo-taiwan overlay."
	if use examples ; then
		einfo
		elog "It would be very useful to take a look at /usr/share/sample/${PF}/imexample"
		elog "directory if you were really interested in developing im server(s) for ${PN}"
	fi
	einfo
}
