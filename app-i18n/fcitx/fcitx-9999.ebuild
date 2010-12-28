# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4_pre1"

EHG_REVISION="default"
EHG_REPO_URI="https://fcitx.googlecode.com/hg"
inherit autotools mercurial

DESCRIPTION="Free Chinese Input Toy for X. Another Chinese XIM Input Method"
HOMEPAGE="http://fcitx.googlecode.com"
SRC_URI="${HOMEPAGE}/files/pinyin.tar.gz ${HOMEPAGE}/files/table.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="dbus debug +pango"
RESTRICT="mirror"

RDEPEND="media-libs/fontconfig
	x11-libs/cairo[X]
	x11-libs/libX11
	x11-libs/libXrender
	dbus? ( sys-apps/dbus )
	pango? ( x11-libs/pango )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext
	x11-proto/xproto"

src_prepare() {
	cp -v "${DISTDIR}"/pinyin.tar.gz "${S}"/data && \
	cp -v "${DISTDIR}"/table.tar.gz "${S}"/data/table || \
	die "failed to copy code tables"

	epatch "${FILESDIR}"/${PN}-remove-md5checks.patch
	intltoolize -c -f || die "failed to run intltoolize"
	eautoreconf
}

src_configure() {
	econf --enable-tray		\
		--enable-recording	\
		$(use_enable dbus)	\
		$(use_enable debug)	\
		$(use_enable pango)
}

pkg_postinst() {
	einfo "This is not an official release. Please report your bugs to:"
	einfo "http://code.google.com/p/fcitx/issues/list"
	echo
	elog "You should export the following variables to use fcitx"
	elog " export XMODIFIERS=\"@im=fcitx\""
	elog " export XIM=\"fcitx\""
	elog " export GTK_IM_MODULE=\"fcitx\""
	elog " export QT_IM_MODULE=\"fcitx\""
}
