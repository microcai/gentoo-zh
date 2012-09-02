# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/rime-data/rime-data-0.9.2.ebuild,v 1.2 2012/09/01 10:47:34 yngwin Exp $

EAPI=4

inherit vcs-snapshot

DESCRIPTION="Data resources for Rime Input Method Engine"
HOMEPAGE="http://code.google.com/p/rimeime/"
SRC_URI="https://github.com/lotem/brise/tarball/rime-${PV} -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-i18n/librime"
RDEPEND="${DEPEND}"

src_prepare() {
	cp "${FILESDIR}"/Makefile "${S}" || die
}
