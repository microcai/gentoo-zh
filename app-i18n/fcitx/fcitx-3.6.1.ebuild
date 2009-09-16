# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit autotools

DESCRIPTION="Free Chinese Input Toy for X. Another Chinese XIM Input Method"
HOMEPAGE="http://fcitx.googlecode.com"
SRC_URI="http://www.fcitx.org/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXpm
	x11-libs/libXrender
	x11-libs/libXt
	x11-libs/libXft"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	eautoreconf
}

src_compile() {
	econf --enable-xft --enable-tray || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog README THANKS TODO

	dodoc doc/pinyin.txt doc/cjkvinput.txt
	dohtml doc/wb_fh.htm
}

pkg_postinst() {
	elog
	elog "You should export the following variables to use fcitx"
	elog " export XMODIFIERS=\"@im=fcitx\""
	elog " export XIM=fcitx"
	elog " export XIM_PROGRAM=fcitx"
	elog
	elog "If you want to use WuBi ,ErBi or something else."
	elog " cp /usr/share/fcitx/data/wbx.mb ~/.fcitx"
	elog " cp /usr/share/fcitx/data/erbi.mb ~/.fcitx"
	elog " cp /usr/share/fcitx/data/tables.conf ~/.fcitx"
	elog
}
