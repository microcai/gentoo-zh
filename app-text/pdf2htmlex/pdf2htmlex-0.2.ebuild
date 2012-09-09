# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils git-2

DESCRIPTION="Convert PDF to HTML without losing format. Text is preserved as
much as possible."
HOMEPAGE="https://github.com/coolwanglu/pdf2htmlEX"

#SRC_URI="https://github.com/coolwanglu/pdf2htmlEX/tarball/${PV} -> ${P}.tar.gz"

EGIT_REPO_URI="git://github.com/coolwanglu/pdf2htmlEX.git"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~86"

IUSE=""

#want c++11
LATESTCXX="|| ( >=sys-devel/gcc-4.7   )"

DEPEND="$LATESTCXX
	>=app-text/poppler-0.20.2[cxx,cairo,cjk]
	>=media-gfx/fontforge-20110222-r1
	>=dev-libs/boost-1.50
"
RDEPEND="${DEPEND}"

pkg_setup(){
	einfo "You need to have gcc-4.7 and set gcc-4.7 active"
}

