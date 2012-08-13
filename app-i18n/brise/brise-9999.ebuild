# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit git-2
DESCRIPTION="Brise, data resource for Rime Input Method Engine"
HOMEPAGE="http://code.google.com/p/rimeime/"
EGIT_REPO_URI="git://github.com/lotem/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="app-i18n/librime"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}

src_prepare() {
	cp ${FILESDIR}/Makefile $S || die
}
