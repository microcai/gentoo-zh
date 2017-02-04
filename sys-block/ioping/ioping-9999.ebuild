# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
EGIT_REPO_URI="https://code.google.com/p/ioping/"
inherit git-2

DESCRIPTION="simple disk I/0 latency measuring tool"
HOMEPAGE="http://code.google.com/p/ioping/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install()
{
	dobin ioping
	doman ioping.1
}
