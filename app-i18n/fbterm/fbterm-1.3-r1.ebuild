# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit base flag-o-matic

DESCRIPTION="fast FrameBuffer based TERMinal emulator for Linux"
HOMEPAGE="http://fbterm.googlecode.com"
SRC_URI="http://fbterm.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="media-libs/fontconfig
	>=media-libs/freetype-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

# http://code.google.com/p/fbterm/issues/detail?id=8#c6
# temporary workaround (patch from upstream, thanks goes to zgchan317)
PATCHES=( "${FILESDIR}/fscap-remove.patch" )
# /usr/bin/fbterm is setXid, dyn linked, and using lazy bindings
append-ldflags "-Wl,-z,now"

src_install() {
	base_src_install
	dodoc AUTHORS NEWS README im/inputmethod.txt

	if use doc; then
		docinto samplecode
		dodoc im/*.{cpp,c,h} im/Makefile*
	fi
}

pkg_postinst() {
	echo
	elog "To use ${PN}, ensure you are in video group."
	if use doc ; then
		elog "It would be very useful to take a look at /usr/share/doc/${PF}/im"
		elog "directory, if you were really interested in developing im server for ${PN}"
	fi
	echo
}
