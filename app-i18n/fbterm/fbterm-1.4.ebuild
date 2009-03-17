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

RDEPEND="sys-libs/glibc
	media-libs/fontconfig
	>=media-libs/freetype-2"
DEPEND="${RDEPEND}
	sys-libs/ncurses
	dev-util/pkgconfig"

# http://code.google.com/p/fbterm/issues/detail?id=8#c6
#PATCHES=( "${FILESDIR}/fscap-remove.patch" )

src_install() {
	base_src_install
	dodoc AUTHORS NEWS README doc/inputmethod.txt
	$(type -P tic) -o "${D}/usr/share/terminfo/" \
		"${S}"/terminfo/fbterm || die "Failed to generate terminfo database"
}

pkg_postinst() {
	# Copied from debian patch
	einfo
	elog "${PN} won't work with vga16fb. You have to use other native"
	elog "framebuffer drivers or vesa driver."
	elog "\tSee /usr/share/doc/${PVR}/README for details."
	elog "\tTo use ${PN}, ensure You are in video group."
	elog "\tTo input CJK merge \"app-i18n/fbterm-ucimf\""
	einfo
	elog "Starting from ${PV}, fbterm has 256 color mode support. To enable this"
	elog "feature set the following environment in your virtual terminal:"
	elog "export TERM=fbterm"
	einfo
}
