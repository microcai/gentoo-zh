# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_P="${P}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Libs required by ksqirrel"
HOMEPAGE="http://ksquirrel.sourceforge.net/"
SRC_URI="mirror://sourceforge/ksquirrel/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="djvu camera jng jpeg jpeg2k kdeenablefinal mng png svg tiff truetype wmf"

#IUSE="gif openexr dxf"
#DEPEND="gif? ( ??-??/libungif )
#	openexr? ( 
#		??-??/libImath
#		??-??/libIHalf
#		??-??/libIlmImf
#		??-??/libIex
#		)
#	dxf? ( ??-??/vec2web )"
DEPEND="djvu? ( app-text/djvu )
	jng? (
		media-libs/jpeg
		media-libs/libmng
		)
	jpeg? ( media-libs/jpeg )
	jpeg2k? ( media-libs/jasper )
	mng? ( media-libs/libmng )
	png? ( media-libs/libpng )
	svg? (
		x11-libs/libsvg-cairo
		media-libs/libpixman
		)
	tiff? ( media-libs/tiff )
	truetype? ( media-libs/freetype )
	wmf? ( media-libs/libwmf )"
RDEPEND="${DEPEND}"

src_compile() {
	local myconf="$(use camera || echo '--disable-camera')
					$(use djvu || echo '--disable-djvu')
					$(use jpeg2k || echo '--disable-jpeg2000')
					$(use mng || echo '--disable-mng')
					$(use svg || echo '--disable-svg')
					$(use truetype || echo '--disable-ttf')
					$(use wmf || echo '--disable-wmf')
					$(use kdeenablefinal && '--enable-final')"
#					$(use gif || echo --disable-gif)
#					$(use openexr || echo '--disable-openexr')
#					$(use dxf || echo '--disable-dxf)
	econf ${myconf} || die "econf faild"
	emake || die "emake faild"
}

src_install() {
	make DESTDIR="${D}" install || die "make install faild"
	mv "${D}/usr/share/doc/${PN}/${PV}" "${D}/usr/share/doc/${P}"
	rmdir "${D}/usr/share/doc/${PN}"
	dodoc README
}
