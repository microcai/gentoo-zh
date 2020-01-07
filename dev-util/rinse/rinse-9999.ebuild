# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit git-2

DESCRIPTION="RPM based distributions bootstrap scripts"
HOMEPAGE="http://collab-maint.alioth.debian.org/rinse/"
EGIT_REPO_URI="git://anonscm.debian.org/collab-maint/rinse.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="
	app-arch/rpm
	dev-perl/libwww-perl"

src_install() {
	emake PREFIX="${D}" install || die "install failed"
}
