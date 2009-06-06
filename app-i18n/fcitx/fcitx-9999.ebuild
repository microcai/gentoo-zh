# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

ESVN_REPO_URI="http://fcitx.googlecode.com/svn/trunk"
inherit autotools subversion

DESCRIPTION="Free Chinese Input Toy for X. Another Chinese XIM Input Method"
HOMEPAGE="http://fcitx.googlecode.com"
SRC_URI="http://gentoo-china-overlay.googlecode.com/svn/distfiles/zhengma.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="" # zhengma

RDEPEND="x11-libs/libX11
	x11-libs/libXpm
	x11-libs/libXrender
	x11-libs/libXt
	x11-libs/libXft"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	subversion_src_unpack
	unpack ${A}

	# Add zhengma support
	#if use zhengma ; then
		mv "${S}"/zhm "${S}"/data/zhengma.txt
		epatch "${FILESDIR}"/add-zhengma-support.diff
	#fi

	# change homepage and version naming scheme
	sed -i \
		-e "s#\(\([[:digit:]]\.\)\+[[:digit:]]\-*\)[[:alnum:]]*#\1SVN-$(date +%y%m%d)#" \
		configure.in || die "sed failed 1"
	sed -i \
		-e "s#http://www\.fcitx\.org#${HOMEPAGE}#" \
		src/InputWindow.c || die "sed failed 2"
	eautoreconf
}

src_compile() {
	econf --enable-xft --enable-tray
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"

	dodoc AUTHORS ChangeLog README THANKS TODO

	# Remove empty directory
	#rmdir "${D}"/usr/share/fcitx/xpm

	rm -rf "${D}"/usr/share/fcitx/doc/ || die "failed to rm docs"
	dodoc doc/pinyin.txt doc/cjkvinput.txt
	dohtml doc/wb_fh.htm
}

pkg_postinst() {
	einfo "This is not an official release. Please report you bugs to:"
	einfo "http://code.google.com/p/fcitx/issues/list"
	echo
	elog "You should export the following variables to use fcitx"
	elog " export XMODIFIERS=\"@im=fcitx\""
	elog " export XIM=fcitx"
	elog " export XIM_PROGRAM=fcitx"
	einfo
	elog "If you want to use WuBi, ErBi or zhengma"
	elog " cp /usr/share/fcitx/data/wbx.mb ~/.fcitx"
	elog " cp /usr/share/fcitx/data/erbi.mb ~/.fcitx"
	elog " cp /usr/share/fcitx/data/zhengma.mb ~/.fcitx"
	elog " cp /usr/share/fcitx/data/tables.conf ~/.fcitx"
	echo
}
