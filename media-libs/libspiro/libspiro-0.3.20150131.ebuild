# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Spiro is the creation of Raph Levien. It simplifies the drawing of beautiful curves."
HOMEPAGE="https://github.com/fontforge/libspiro"
SRC_URI="https://github.com/fontforge/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""

IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare(){
	eautoreconf
}
