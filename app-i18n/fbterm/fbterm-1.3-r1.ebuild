# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit base

DESCRIPTION="fast FrameBuffer based TERMinal emulator for Linux"
HOMEPAGE="http://fbterm.googlecode.com"
SRC_URI="http://fbterm.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND="media-libs/fontconfig
	>=media-libs/freetype-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

# http://code.google.com/p/fbterm/issues/detail?id=8#c6
PATCHES=( "${FILESDIR}/fscap-remove.patch" )

src_install() {
	base_src_install
	dodoc AUTHORS NEWS README

	if use examples; then
		docinto imexample
		dodoc im/*.{cpp,c,h} im/Makefile*  im/inputmethod.txt
		dobin im/imexample
	fi
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
