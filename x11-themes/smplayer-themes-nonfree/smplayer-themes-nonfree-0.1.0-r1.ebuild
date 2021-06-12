# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Icon themes for smplayer"
HOMEPAGE="http://smplayer.sourceforge.net/"
SRC_URI="mirror://sourceforge/smplayer/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ~ppc ~ppc64 x86 ~amd64-linux"
IUSE=""
DEPEND=""
RDEPEND="media-video/smplayer"

# Override it as default will call make that will cath the install target...
src_compile() {
	return
}

src_install() {
	insinto /usr/share/smplayer
	doins -r themes || die "Failed to install themes"
	dodoc Changelog README.txt
}
