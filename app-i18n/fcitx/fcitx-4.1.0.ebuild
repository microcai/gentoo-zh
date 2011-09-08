# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit cmake-utils eutils

DESCRIPTION="Free Chinese Input Toy for X. Another Chinese XIM Input Method"
HOMEPAGE="http://www.fcitx.org/"
SRC_URI="http://fcitx.googlecode.com/files/${P}_all.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cairo dbus debug gtk gtk3 kde opencc pango"

RDEPEND="x11-libs/libX11
	x11-libs/libXrender
	media-libs/fontconfig
	pango? ( x11-libs/pango )
	opencc? ( app-i18n/opencc )
	gtk? ( x11-libs/gtk+:2 )
	gtk3? ( x11-libs/gtk+:3 )
	cairo? ( x11-libs/cairo[X] )
	dbus? ( sys-apps/dbus )"
DEPEND="${RDEPEND}
	x11-proto/xproto
	dev-util/pkgconfig"

PDEPEND="kde? ( app-i18n/kcm-fcitx )
	gtk? ( >=app-i18n/fcitx-configtool-0.3.0 )"

src_prepare() {
	epatch "${FILESDIR}/${P}-fix-ldflags.patch"
}

src_configure() {
	local mycmakeargs="
		$(cmake-utils_use_enable cairo)
		$(cmake-utils_use_enable dbus)
		$(cmake-utils_use_enable debug)
		$(cmake-utils_use_enable gtk gtk2_im_module)
		$(cmake-utils_use_enable gtk3 gtk3_im_module)
		$(cmake-utils_use_enable opencc)
		$(cmake-utils_use_enable pango)"
		cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	dodoc AUTHORS ChangeLog README THANKS TODO || die

	rm -rf "${ED}"/usr/share/fcitx/doc/ || die
	dodoc doc/pinyin.txt doc/cjkvinput.txt || die
	dohtml doc/wb_fh.htm || die
}

pkg_postinst() {
	elog
	elog "You should export the following variables to use fcitx"
	elog " export XMODIFIERS=\"@im=fcitx\""
	elog " export XIM=fcitx"
	elog " export XIM_PROGRAM=fcitx"
	elog " export QT_IM_MODULE=fcitx"
	elog " export GTK_IM_MODULE=fcitx"
	elog
	elog "If you want to use WuBi ,ErBi or something else."
	elog " mkdir -p ~/.fcitx"
	elog " cp /usr/share/fcitx/data/wbx.mb ~/.fcitx"
	elog " cp /usr/share/fcitx/data/erbi.mb ~/.fcitx"
	elog " cp /usr/share/fcitx/data/tables.conf ~/.fcitx"
	elog
}
