# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils subversion

DESCRIPTION="Chrasis SCIM binding for chinese character recognition."
HOMEPAGE="http://chrasis.berlios.de/"
#SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="nls"

DEPEND=">=app-i18n/scim-1.2.0
	>=x11-libs/gtk+-2.12.0
	dev-libs/libchrasis"

RDEPEND="${DEPEND}"

src_unpack()
{
	ESVN_REPO_URI="svn://svn.berlios.de/chrasis/Linux/scim-chrasis/trunk"
	ESVN_PROJECT="scim-chrasis"
	#ESVN_PATCHES="*.diff"
	#ESVN_BOOTSTRAP="./autogen.sh"
	subversion_src_unpack
}

src_compile() {
	glib-gettextize -f
	./autogen.sh
	econf $(use_enable nls) || die "Error: econf failed!"
	emake || die "Error: emake failed!"
}

src_install() {
	make DESTDIR=${D} install || die "Error: install failed!"
	dodoc ChangeLog README
}

#pkg_postinst() {
#
#	elog
#	elog "The SCIM input pad should be startable from the SCIM (and Skim)"
#	elog "systray icon right click menu. You will have to restart SCIM"
#	elog "(or Skim) in order for the menu entry to appear (you may simply"
#	elog "restart your X server). If you want to use it immediately, just"
#	elog "start the SCIM input pad, using the 'scim-input-pad' command."
#	elog
#	elog "To use, select the text zone you wish to write in, and just"
#	elog "click on the wanted character in the right multilevel tabbed"
#	elog "table, from the SCIM Input Pad interface."
#	elog
#	elog "To add new characters to the tables, see the documentation"
#	elog "(/usr/share/doc/${PF}/README.gz)."
#	elog
#
#}
