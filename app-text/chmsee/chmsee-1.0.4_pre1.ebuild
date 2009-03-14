# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_P=${P/_/-}
DESCRIPTION="HTML Help viewer for Unix/Linux"
HOMEPAGE="http://chmsee.googlecode.com"
SRC_URI="http://chmsee.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="nls"

RDEPEND=">=gnome-base/libglade-2.4
	>=x11-libs/gtk+-2.8
	dev-libs/chmlib
	dev-libs/libgcrypt
	net-libs/xulrunner"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	>=dev-util/intltool-0.38
	dev-util/pkgconfig"

RESTRICT="mirror"
S=${WORKDIR}/${MY_P}
DOCS="AUTHORS NEWS README TODO"

src_compile() {
	econf \
		$(use_enable nls) \
		--with-gecko=libxul
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"
	dodoc NEWS* README* THANKS AUTHORS TODO ChangeLog
}
