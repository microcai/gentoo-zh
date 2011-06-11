# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit eutils

DESCRIPTION="fast FrameBuffer based TERMinal emulator for Linux"
HOMEPAGE="http://fbterm.googlecode.com"
#SRC_URI="http://fbterm.googlecode.com/files/${P}.tar.gz"
SRC_URI="http://fbterm.googlecode.com/files/${P}.0.tar.gz" # workaround naming

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gpm video_cards_vesa caps"

RDEPEND=">=media-libs/freetype-2
	gpm? ( sys-libs/gpm )
	media-libs/fontconfig
	caps? ( sys-libs/libcap ) 
	video_cards_vesa? ( dev-libs/libx86 )"
DEPEND="${RDEPEND}
	sys-libs/ncurses
	dev-util/pkgconfig"

src_configure() {
	econf $(use_enable gpm) $(use_enable video_cards_vesa vesa)
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"

	dodoc AUTHORS NEWS README
	$(type -P tic) -o "${D}/usr/share/terminfo/" \
		"${S}"/terminfo/fbterm || die "Failed to generate terminfo database"
}

pkg_postinst() {
	#
	if use caps ;then
		setcap "cap_sys_tty_config+ep" "${ROOT}"/usr/bin/fbterm
	else
		chmod u+s "${ROOT}"/usr/bin/fbterm
	fi

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
