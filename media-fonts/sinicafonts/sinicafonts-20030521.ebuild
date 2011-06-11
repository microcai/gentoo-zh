# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/media-fonts/sinicafonts/sinicafonts-20030521.ebuild,v 1.4 2006/05/27 11:45:49 palatis Exp $

RESTRICT="nostrip"

DESCRIPTION="Chinese and Siddam fonts provided by SINICA, Taiwan."
HOMEPAGE="http://www.sinica.edu.tw/~cdp/
	ftp://cle.linux.org.tw/pub2/fonts/sinica/"

BASE_SRC_URI="ftp://cle.linux.org.tw/pub2/fonts/sinica/"	
SRC_URI="
	${BASE_SRC_URI}/hzk1.ttf
	${BASE_SRC_URI}/hzk2.ttf
	${BASE_SRC_URI}/hzk3.ttf
	${BASE_SRC_URI}/hzk4.ttf
	${BASE_SRC_URI}/hzk5.ttf
	${BASE_SRC_URI}/hzk6.ttf
	${BASE_SRC_URI}/hzk7.ttf
	${BASE_SRC_URI}/hzk8.ttf
	${BASE_SRC_URI}/hzk9.ttf
	${BASE_SRC_URI}/hzka.ttf
	${BASE_SRC_URI}/hzkb.ttf
	${BASE_SRC_URI}/hzkc.ttf
	${BASE_SRC_URI}/siddam.zip"

TRUETYPE_FONTS="hzk1.ttf
	hzk2.ttf
	hzk3.ttf
	hzk4.ttf
	hzk5.ttf
	hzk6.ttf
	hzk7.ttf
	hzk8.ttf
	hzk9.ttf
	hzka.ttf
	hzkb.ttf
	hzkc.ttf"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

RDEPEND="app-arch/unzip"
S=${WORKDIR}

src_unpack() {
	cd ${S}
	unzip ${DISTDIR}/siddam.zip
}

src_compile() {
	return
}

src_install() {
	insinto /usr/share/fonts/ttf/chinese/sinica
	for I in ${TRUETYPE_FONTS}; do
		doins ${DISTDIR}/${I}
	done

	insinto /usr/share/fonts/ttf/chinese/sinica/siddam
	cd ${S}
	doins foreign1.TTF
	doins SIDDAM.TTF
}

pkg_postinst() {
        einfo "Creating fonts.scale and fonts.dir info for SINICA fonts"
        cd /usr/share/fonts/ttf/chinese/sinica
	mkfontscale -e /usr/share/fonts/encodings/large -e /usr/share/fonts/encodings
        mkfontdir -e /usr/share/fonts/encodings/large -e /usr/share/fonts/encodings

        einfo "Creating fonts.scale and fonts.dir info for siddam fonts"
        cd /usr/share/fonts/ttf/chinese/sinica/siddam
	mkfontscale -e /usr/share/fonts/encodings/large -e /usr/share/fonts/encodings
        mkfontdir -e /usr/share/fonts/encodings/large -e /usr/share/fonts/encodings

	einfo "Creating font cache... This may take *SOME* times."
	fc-cache -f

        einfo
        if (  `grep -e "^.*FontPath.*\"/usr/share/fonts/ttf/chinese/sinica\"" /etc/X11/XF86Config -q` ); then
                einfo "Font path for sinica fonts is listed in /etc/X11/XF86Config."
        else
                einfo "You must add /usr/share/fonts/ttf/chinese/sinica to your font path"
                einfo "to be able to use your new sinica fonts."
        fi

        einfo
        if (  `grep -e "^.*FontPath.*\"/usr/share/fonts/ttf/chinese/sinica/siddam\"" /etc/X11/XF86Config -q` ); then
                einfo "Font path for sinica siddam fonts is listed in /etc/X11/XF86Config."
        else
                einfo "You must add /usr/share/fonts/ttf/chinese/sinica/siddam to your font path"
                einfo "to be able to use your new siddam fonts."
        fi
}
