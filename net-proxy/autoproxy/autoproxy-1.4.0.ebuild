# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit autotools

HOMEPAGE="http://forum.ubuntu.org.cn/viewtopic.php?f=1&t=272559"
DESCRIPTION="Forward/transparent proxy server that route destinations based on URLs"
SRC_URI="http://microcai.fedorapeople.org/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="gtk gtk3 systemd"

DEPEND="
gtk3? ( x11-libs/gtk+:3 )

gtk? (
	|| ( >=x11-libs/gtk+-2.23:2 x11-libs/gtk+:3 )
)
	>=dev-libs/glib-2.26
"

RDEPEND="${DEPEND}
systemd? ( sys-apps/systemd )
"
src_configure(){
	! use gtk && ! use gtk3 && ECONF="${ECONF} --disable-gui"

	use gtk3 && ECONF+="--with-gtk=3.0"

	econf ${ECONF} ${EXTRA_CONF} || die "configure filed!"
}

src_compile(){
	emake HOME=/root || die
}

src_install(){
	emake install DESTDIR="${D}" || die "make install filed"
}
