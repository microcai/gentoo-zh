# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/app-i18n/scim-chewing-svn/scim-chewing-svn-0.2.0.9999.ebuild,v 1.1 2005/04/19 00:08:13 scsi Exp $
EAPI=3

inherit eutils subversion

DESCRIPTION="Chewing Input Method for SCIM"
HOMEPAGE="http://chewing.csie.net/"
#SRC_URI="http://chewing.csie.net/download/scim/${P}.tar.gz"

ESVN_REPO_URI="https://svn.csie.net/chewing/scim-chewing/trunk"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=app-i18n/scim-1.0.0
		dev-libs/libchewing"

RDEPEND="${DEPEND}"

src_configure(){
	eautoreconf || die
}

src_compile() {
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodoc AUTHORS THANKS README
}

pkg_postinst() {
	einfo
	einfo "To use SCIM with both GTK2 and XIM, you should use the following"
	einfo "in your user startup scripts such as .gnomerc or .xinitrc:"
	einfo
	einfo "LC_ALL='your_language' scim -d"
	einfo "export XMODIFIERS=@im=SCIM"
	einfo
}

