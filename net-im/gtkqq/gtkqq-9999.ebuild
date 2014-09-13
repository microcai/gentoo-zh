# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_BRANCH="dev"
EGIT_REPO_URI="git://github.com/kernelhcy/gtkqq.git"

WANT_AUTOMAKE="1.11" # bug 419455
inherit git-2 autotools eutils

DESCRIPTION="a qq client based on gtk+ uses webqq protocol"
HOMEPAGE="http://github.com/kernelhcy/gtkqq"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	[[ ! -d "${S}/m4" ]] && mkdir "${S}/m4"
	eautoreconf
}
