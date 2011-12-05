# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils

DESCRIPTION="Film-Quality Vector Animation (core engine)"
HOMEPAGE="http://www.synfig.org/"
SRC_URI="mirror://sourceforge/synfig/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="imagemagick ffmpeg dv openexr truetype jpeg tiff fontconfig"

DEPEND=">=dev-libs/libsigc++-2.0.0
	>=dev-cpp/libxmlpp-2.6.1
	>=media-libs/libpng-1.5
	>=dev-cpp/ETL-0.04.14
	ffmpeg? ( virtual/ffmpeg )
	openexr? ( media-libs/openexr )
	truetype? ( >=media-libs/freetype-2.1.9 )
	fontconfig? ( media-libs/fontconfig )
	jpeg? ( virtual/jpeg )
	tiff? ( media-libs/tiff )"

RDEPEND="${DEPEND}
	dv? ( media-libs/libdv )
	imagemagick? ( media-gfx/imagemagick )"

src_prepare() {
	epatch "${FILESDIR}"/synfig_libpng14.patch
	epatch "${FILESDIR}"/synfig_libpng15.patch
}

src_configure() {
	econf \
		$(use_with ffmpeg) \
		$(use_with fontconfig) \
		$(use_with imagemagick) \
		$(use_with dv libdv) \
		$(use_with openexr ) \
		$(use_with truetype freetype) \
		$(use_with jpeg)
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed!"
	dodoc doc/*.txt || die "Dodoc failed!"
	#insinto /usr/share/${PN}/examples
	#doins examples/*.si{f,fz} || die "Doins failed!"
}
