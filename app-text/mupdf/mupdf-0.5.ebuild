# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

DESCRIPTION="a lightweight PDF viewer and toolkit written in portable C"
HOMEPAGE="http://ccxvii.net/mupdf/"

MY_VERSION="0.5"

SRC_URI="http://ccxvii.net/${PN}/download/${PN}-${MY_VERSION}.tar.gz"
S="${WORKDIR}"/"${PN}-${MY_VERSION}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+cjk jbig jpeg2k"

RDEPEND="sys-libs/zlib
   media-libs/jpeg
   >=media-libs/freetype-2
   jbig? ( media-libs/jbigkit )
   jpeg2k? ( media-libs/jasper )"

DEPEND="${RDEPEND}
   dev-util/ftjam"

src_compile() {
   echo "LINKFLAGS = ${LDFLAGS} ;" >> Jamrules
   echo "OPTIM = ${CFLAGS} ;" >> Jamrules
   echo 'ALL_LOCATE_TARGET = [ FDirName $(TOP) build ] ;' >> Jamrules
   PARAMETER=""
   use cjk || PARAMETER="${PARAMETER} '-sDEFINES=NOCJK'"
   use jbig && PARAMETER="${PARAMETER} '-sHAVE_JBIG2DEC=yes'"
   use jpeg2k && PARAMETER="${PARAMETER} '-sHAVE_JASPER=yes'"
   jam ${PARAMETER} || die "jam failed"
}

src_install() {
   dodoc COPYING README || die "Could not create documents"
   cd build
   dobin cmapdump fontdump mupdf pdfclean pdfdraw pdfextract pdfshow || die "Could not create binaries"
   newbin pdfinfo mupdf_pdfinfo || die "Could not rename pdfinfo -> mupdf_pdfinfo" # avoid collision with app-text/poppler-utils
   dolib.a *.a || die "Could not create libraries"
}
