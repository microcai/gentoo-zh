# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils
DESCRIPTION="Gentoo-specific bash command-line completions (emerge, ebuild, equery, etc)"
HOMEPAGE="http://developer.berlios.de/projects/gentoo-bashcomp/"
SRC_URI="http://download.berlios.de/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sparc x86"
IUSE=""

RDEPEND="app-shells/bash-completion"

src_unpack()
{
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/emerge-fix.patch
}
src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog TODO NEWS
}

pkg_postinst() {
	local g="${ROOT}/etc/bash_completion.d/gentoo"
	if [[ -e "${g}" && ! -L "${g}" ]] ; then
		echo
		ewarn "The gentoo completion functions have moved to /usr/share/bash-completion."
		ewarn "Please run etc-update to replace /etc/bash_completion.d/gentoo with a symlink."
		echo
	fi
}
