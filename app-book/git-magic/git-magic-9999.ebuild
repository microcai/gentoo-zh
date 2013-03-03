# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit git-2

DESCRIPTION="A guild to Git"
HOMEPAGE="http://www-cs-students.stanford.edu/~blynn//gitmagic/"
SRC_URI=""

EGIT_REPO_URI="git://github.com/blynn/gitmagic.git"

LICENSE=""
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="pdf"

LANGS=(zh_CN zh_TW)

DEPEND="app-text/asciidoc
		pdf? ( app-text/xmlto[latex] )
		!pdf? ( app-text/xmlto )
        app-text/htmltidy
	  pdf? ( dev-java/fop )
"
RDEPEND=""

for x in "${LANGS[@]}" ; do
	IUSE="$IUSE linguas_${x/-/_}"
done

bookmake(){
	emake -j1 book-$@.html || die
	if use pdf ; then
		emake -j1 book-$@.pdf || die 
	fi
}

bookins(){
	doins book-$@.html
	use pdf && doins book-$@.pdf
}

src_compile(){
	use linguas_zh_CN && bookmake zh_cn
	use linguas_zh_TW && bookmake zh_tw
}

src_install(){
	dodir /usr/share/${PN}
	insinto /usr/share/${PN}
	use linguas_zh_CN && bookins zh_cn
	use linguas_zh_TW && bookins zh_tw
}

pkg_postinst(){
	einfo "compiled document can be found @ /usr/share/${PN}"
}
