# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Chewing Input Method for SCIM"
HOMEPAGE="http://chewing.csie.net/"
SRC_URI="http://chewing.csie.net/download/scim/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND=">=app-i18n/scim-1.4
		>=dev-libs/libchewing-0.3.1"

src_unpack() {
	unpack "${A}"
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS THANKS README
}

pkg_postinst() {
	einfo
	einfo "To use SCIM with both GTK2 and XIM, you should use the following"
	einfo "in your user startup scripts such as .gnomerc or .xinitrc:"
	einfo
	einfo "LANG='your_language' scim -d"
	einfo "export XMODIFIERS=@im=SCIM"
	einfo
}
