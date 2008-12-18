# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils linux-info

DESCRIPTION="fast FrameBuffer based TERMinal emulator for Linux"
HOMEPAGE="http://fbterm.googlecode.com"
SRC_URI="http://fbterm.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="ucimf"

RDEPEND="media-libs/fontconfig
	>=media-libs/freetype-2
	ucimf? ( app-i18n/libucimf )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_config() {
	# FIXME
	if !(linux_chkconfig_present CONFIG_FB); then
		eerror "You don't have framebuffer support, please check your kernel configuration!"
		die "You don't have framebuffer support, please check your kernel configuration!"
	fi
}

src_unpack() {
	unpack ${A}

	# patch from Chun-Yu Lee (Mat) http://ucimf.sourceforge.net
	if use ucimf ; then
		cd "${S}" && epatch "${FILESDIR}"/${P}-ucimf.patch
	fi
}

src_compile() {
	LIBS=-lucimf econf
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"
	dodoc AUTHORS NEWS README
}

pkg_postinst() {
	echo
	elog "To use ${PN}, add yourself into video group."
	if use ucimf ; then
		elog "You can use \"ucimf\" command to start fbterm."
	fi
	echo
}
