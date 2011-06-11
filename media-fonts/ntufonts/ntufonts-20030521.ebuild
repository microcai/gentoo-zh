# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/media-fonts/ntufonts/ntufonts-20030521.ebuild,v 1.5 2006/05/27 11:45:49 palatis Exp $

RESTRICT="nostrip"

DESCRIPTION="Chinese Fonts from National Taiwan University, Includes kai, Lei, Funsong, and Thin."
HOMEPAGE="
	http://www.csie.ntu.edu.tw/
	ftp://cle.linux.org.tw/pub2/fonts/ttf/big5/ntu/"

BASE_SRC_URI="ftp://cle.linux.org.tw/pub2/fonts/ttf/big5/ntu/"
SRC_URI="
	${BASE_SRC_URI}/NTU_FS_M.TTF
	${BASE_SRC_URI}/NTU_KAI.TTF
	${BASE_SRC_URI}/NTU_LI_M.TTF
	${BASE_SRC_URI}/NTU_MB.TTF
	${BASE_SRC_URI}/NTU_MM.TTF
	${BASE_SRC_URI}/NTU_MR.TTF
	${BASE_SRC_URI}/NTU_TW.TTF"

TRUETYPE_FONTS="NTU_FS_M.TTF
	NTU_KAI.TTF
	NTU_LI_M.TTF
	NTU_MB.TTF
	NTU_MM.TTF
	NTU_MR.TTF
	NTU_TW.TTF"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND=""
S=${WORKDIR}

src_unpack() {
	einfo "Nothing to do for unpack."
	return
}

src_compile() {
	einfo "Nothing to do for compile, either."
	return
}

src_install() {
	insinto /usr/share/fonts/ttf/chinese/${PN}
	for I in ${TRUETYPE_FONTS}; do
		doins ${DISTDIR}/${I}
	done
}
pkg_postinst() {
        einfo "Creating fonts.scale and fonts.dir info for TrueType fonts"
        cd /usr/share/fonts/ttf/chinese/${PN}
	mkfontscale -e /usr/share/fonts/encodings/large -e /usr/share/fonts/encodings
        mkfontdir -e /usr/share/fonts/encodings/large -e /usr/share/fonts/encodings

	einfo "Creating font cache... This may take *SOME* times."
	fc-cache -f

        einfo
        if (  `grep -e "^.*FontPath.*\"/usr/share/fonts/ttf/chinese/${PN}\"" /etc/X11/XF86Config -q` ); then
                einfo "Font path for ${PN} is listed in /etc/X11/XF86Config."
        else
                einfo "You must add /usr/share/fonts/ttf/chinese/${PN} to your font path"
                einfo "to be able to use your new ${PN} fonts."
        fi
}
