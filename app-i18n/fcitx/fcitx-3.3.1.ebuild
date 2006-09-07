# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Free Chinese Input Toy for X. Another Chinese XIM Input Method"
HOMEPAGE="http://www.fcitx.org/"
SRC_URI="http://www.fcitx.org/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="truetype"

DEPEND="|| ( ( x11-libs/libX11 x11-libs/libXrender x11-libs/libXt )
		virtual/x11 )
	truetype? ( || ( x11-libs/libXft virtual/xft ) )"

src_compile() {
	econf $(use_enable truetype xft) || die "configure failed"
	emake || die "make failed"
}

src_install()
{
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog README THANKS TODO

	rm -rf "${D}"/usr/share/fcitx/doc/
	dodoc doc/pinyin.txt doc/cjkvinput.txt doc/fcitx3.pdf
	dohtml doc/wb_fh.htm
}

pkg_postinst()
{
	einfo "You should export the following variables to use fcitx"
	einfo " export XMODIFIERS=\"@im=fcitx\""
	einfo " export XIM=fcitx"
	einfo " export XIM_PROGRAM=fcitx"
	einfo ""
	einfo "If you want to use WuBi or ErBi"
	einfo " cp /usr/share/fcitx/data/wbx.mb ~/.fcitx"
	einfo " cp /usr/share/fcitx/data/erbi.mb ~/.fcitx"
	einfo " cp /usr/share/fcitx/data/tables.conf ~/.fcitx"
	einfo ""
	einfo "Note that fcitx only works in the zh_CN locale."
}
