# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils git

DESCRIPTION="XeLaTeX package for using unicode/OpenType maths fonts"
HOMEPAGE="http://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&item_id=xetex"
EGIT_REPO_URI="git://github.com/wspr/unicode-math.git"

LICENSE="LPPL-1.3c"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=">=app-text/xetex-0.995"
RDEPEND="${DEPEND}"

src_unpack() {
	git_src_unpack
}


src_install() {
	dodir /usr/share/texmf/tex/xelatex/unicode-math
	insinto /usr/share/texmf/tex/xelatex/unicode-math
	doins *

}

pkg_postinst() {
	einfo "Running mktexlsr to rebuild ls-R database...."
	mktexlsr
}

pkg_postrm() {
	einfo "Running mktexlsr to rebuild ls-R database...."
	mktexlsr
}
