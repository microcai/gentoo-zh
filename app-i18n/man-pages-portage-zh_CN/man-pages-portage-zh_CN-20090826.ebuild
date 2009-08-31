# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:$

DESCRIPTION="Portage English-Chinese Bilingual Manual Page"
HOMEPAGE="http://code.google.com/p/egentoo"
SRC_URI="http://egentoo.googlecode.com/svn/trunk/shuge-utils/${P}.tar.gz"

LICENSE="FDL-1.2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="virtual/man"

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -r `find . -type d -name .svn`
}

src_compile() {
	make u8 || die
}

src_install() {
	make install DESTDIR="${D}"/usr/share || die "install failled"
	dodoc DOCS/* || die "install docs failled"
}

pkg_postinst() {
	elog "To use man-pages-portage-zh, You should:"
	elog "   set following in your user startup scripts"
	elog "   such as .bashrc, .xinitrc, .xsession or .xprofile:"
	elog
	elog "   alias cman='man -M /usr/share/man/zh_CN.UTF-8/ '"
}

