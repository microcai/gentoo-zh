# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# openfetion by LWP (levin108@gmail.com), ebuild by viogus (zhixun.lin@gmail.com)
EAPI="2"

inherit  eutils

DESCRIPTION="A GTK IM client using CHINA MOBILE's Fetion Protocol 4"
HOMEPAGE="http://code.google.com/p/ofetion/"
SRC_URI="http://ofetion.googlecode.com/files/${P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="-gstreamer -notify -debug"

DEPEND="gstreamer? ( media-libs/gstreamer )
		notify? ( x11-libs/libnotify )
		dev-libs/openssl
		>=x11-libs/gtk+-2.16.6
		dev-libs/libxml2"
RDEPEND=${DEPEND}
src_prepare() {
	#seg fault without this patch on my x86 box
	epatch "${FILESDIR}/${P}-treeview-fixed.patch"
	#fix ui order
	epatch "${FILESDIR}/${P}-no-stranger.patch"
	#fix gentoo QA warning
	epatch "${FILESDIR}/${PN}-gentoo-qa-warning.patch"
}

src_configure() {
	local myconf=""
	use debug && myconf="${myconf} --enable-debug"
	econf ${myconf}
}
src_install() {
#	einstall
	emake DESTDIR="${D}" install || die "Install failed"

#   do some cleanup

#clean up the makefiles unwanted
	rm ${D}/usr/share/openfetion/skin/face_images/Makefile{,.in,.am}

#without gstreamer , newmessage.wav is useless
	use gstreamer || rm "${D}/usr/share/openfetion/resource/newmessage.wav"

	einfo ""
	einfo "To use the sound reminder function, please enable gstreamer USE flag"
	einfo "and compile it again."
	einfo "v1.6 has some new feature, you might need to clean some data"
	einfo "cd ~/.openfetion && rm global.dat && find . -name "config.dat" -exec rm {} \;;"
}
