# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="fast FrameBuffer based TERMinal emulator for Linux"
HOMEPAGE="http://fbterm.googlecode.com"
SRC_URI="http://fbterm.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/libc
	media-libs/fontconfig
	>=media-libs/freetype-2"
DEPEND="${RDEPEND}
	sys-libs/ncurses
	dev-util/pkgconfig"

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"

	dodoc AUTHORS NEWS README doc/inputmethod.txt
	$(type -P tic) -o "${D}/usr/share/terminfo/" \
		"${S}"/terminfo/fbterm || die "Failed to generate terminfo database"
}

pkg_postinst() {
	# Copied from debian patch
	einfo
	elog "${PN} won't work with vga16fb. You have to use other native"
	elog "framebuffer drivers or vesa driver."
	elog "  See /usr/share/doc/${PVR}/README for details."
	elog "  To use ${PN}, ensure You are in video group."
	elog "  To input CJK merge \"app-i18n/fbterm-ucimf\""
	einfo
	elog "Starting from version 1.4, fbterm has internal 256 color mode"
	elog "support. To enable this feature set the following environment"
	elog "in your virtual terminal before/after running it:"
	elog "export TERM=fbterm"
	einfo
}
