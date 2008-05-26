# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/app-i18n/scim-chewing-svn/scim-chewing-svn-0.2.0.9999.ebuild,v 1.1 2005/04/19 00:08:13 scsi Exp $

inherit eutils subversion

DESCRIPTION="Chewing Input Method for SCIM"
HOMEPAGE="http://chewing.csie.net/"
#SRC_URI="http://chewing.csie.net/download/scim/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="!app-i18n/scim-chewing
		>=app-i18n/scim-1.0.0
		dev-libs/libchewing-svn"


src_unpack() {

	ESVN_REPO_URI="https://svn.csie.net/chewing/scim-chewing/trunk"
	ESVN_PROJECT="scim-chewing"
	#ESVN_PATCHES="*.diff"
	#ESVN_BOOTSTRAP="./autogen.sh"
	subversion_src_unpack

}

src_compile() {
	glib-gettextize -f
	./autogen.sh
	econf || die
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

