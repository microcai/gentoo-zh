# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_P=${P/_p/-svn-}
DESCRIPTION="Free Chinese Input Toy for X. Another Chinese XIM Input Method"
HOMEPAGE="http://fcitx.googlecode.com"
SRC_URI="http://gentoo-china-overlay.googlecode.com/svn/distfiles/${MY_P}.tar.gz"

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

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf --enable-xft
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog README THANKS TODO
	# Remove empty directory
	rm -rf "${D}"/usr/share/fcitx/{xpm,doc} || die "rm failed"
	dodoc doc/pinyin.txt doc/cjkvinput.txt
	dohtml doc/wb_fh.htm
}

pkg_postinst() {
	# FIXME
	einfo
	elog "You should export the following variables to use fcitx"
	elog " export XMODIFIERS=\"@im=fcitx\""
	elog " export XIM=fcitx"
	elog " export XIM_PROGRAM=fcitx"
	einfo
	elog "If you want to use WuBi or ErBi"
	elog " cp /usr/share/fcitx/data/wbx.mb ~/.fcitx"
	elog " cp /usr/share/fcitx/data/erbi.mb ~/.fcitx"
	elog " cp /usr/share/fcitx/data/tables.conf ~/.fcitx"
	einfo
}
