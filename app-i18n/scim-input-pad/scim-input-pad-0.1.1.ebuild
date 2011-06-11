# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/app-i18n/scim-input-pad/scim-input-pad-0.1.1.ebuild,v 1.1 2005/12/19 05:52:11 scsi Exp $

inherit eutils

DESCRIPTION="Chewing Input Method for SCIM"
HOMEPAGE="http://sourceforge.net/projects/scim"
SRC_URI="mirror://sourceforge/scim/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="doc"

DEPEND=">=app-i18n/scim-1.0.0"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	use doc && dodoc AUTHORS THANKS README
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
