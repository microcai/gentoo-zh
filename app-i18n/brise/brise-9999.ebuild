# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

if [[ "${PV}" == "9999" ]] ; then
	S=${WORKDIR}/${PN}
	inherit git-2
	EGIT_REPO_URI="git://github.com/lotem/${PN}.git"
else
	inherit vcs-snapshot
	RESTRICT="primaryuri"
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/lotem/${PN}/tarball/rime-${PV} -> ${P}.tar.gz"
fi

DESCRIPTION="Brise, data resource for Rime Input Method Engine"
HOMEPAGE="http://code.google.com/p/rimeime/"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="app-i18n/librime"



src_prepare() {
	cp ${FILESDIR}/Makefile $S || die
}
