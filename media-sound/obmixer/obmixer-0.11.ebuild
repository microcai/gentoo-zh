# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit autotools

DESCRIPTION="A GTK mixer applet for window managers."
HOMEPAGE="http://jpegserv.com/obmixer"
SRC_URI="http://jpegserv.com/linux/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-util/intltool"

src_prepare() {
	# autogen.sh does more than just run autotools
	# FIXME: cannot use eauto* tools
	sed -i \
		-e 's:^srcdir=.*$:srcdir=${S}:' \
		-e 's:^[\t ]*libtoolize:\t_elibtoolize:' \
		autogen.sh || die "sed failed"
	(. ./autogen.sh) || die "autogen.sh failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	elog "You will need to install either pavucontrol or alsamixergui if you"
	elog "wish to use a mixer from the volume control."
}
