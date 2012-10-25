
# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils vcs-snapshot

DESCRIPTION="Convert PDF to HTML without losing format. Text is preserved as
much as possible."
HOMEPAGE="https://github.com/coolwanglu/pdf2htmlEX"

SRC_URI="https://github.com/coolwanglu/pdf2htmlEX/tarball/v${PV} -> ${P}.tar.gz"

#EGIT_REPO_URI="git://github.com/coolwanglu/pdf2htmlEX.git"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~86"

IUSE=""

COMMON_DEPEND="
	>=media-libs/libpng-1.5
	>=app-text/poppler-0.20[cxx,cairo,cjk]
	>=media-gfx/fontforge-20110222-r1
"


DEPEND="${COMMON_DEPEND}"

RDEPEND="${COMMON_DEPEND}"

pkg_setup(){
	einfo "You need to have at least gcc-4.5"
}

