# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="VIPS Image Processing Library"
SRC_URI="https://github.com/libvips/libvips/releases/download/v${PV}/${P}.tar.xz"
HOMEPAGE="https://libvips.github.io/libvips/"

LICENSE="LGPL-2.1+"
SLOT="1"
KEYWORDS="~amd64 ~arm64"
IUSE="doc exif fftw fits heif gsf graphicsmagick imagemagick imagequant jpeg lcms openexr orc pango pdf png svg static-libs tiff webp zlib matio"

RDEPEND="
	>=dev-libs/glib-2.6:2
	dev-libs/expat:=
	fftw? ( sci-libs/fftw:3.0= )
	imagemagick? (
		graphicsmagick? ( media-gfx/graphicsmagick )
		!graphicsmagick? ( media-gfx/imagemagick )
	)
	imagequant? ( media-gfx/libimagequant:= )
	exif? ( >=media-libs/libexif-0.6 )
	fits? ( sci-libs/cfitsio )
	heif? ( >=media-libs/libheif-1.3.0:= )
	jpeg? ( media-libs/libjpeg-turbo:0= )
	gsf? ( gnome-extra/libgsf:= )
	lcms? ( media-libs/lcms )
	openexr? ( >=media-libs/openexr-1.2.2:= )
	orc? ( >=dev-lang/orc-0.4.11 )
	pango? ( x11-libs/pango )
	pdf? ( app-text/poppler[cairo] )
	png? ( >=media-libs/libpng-1.2.9:0= )
	svg? ( gnome-base/librsvg )
	tiff? ( media-libs/tiff:0= )
	webp? ( media-libs/libwebp )
	zlib? ( sys-libs/zlib )
	matio? ( sci-libs/matio )
"

DEPEND="
	doc? (
		dev-util/gtk-doc
		dev-util/gtk-doc-am
	)
	${RDEPEND}
"

src_configure() {
	local emesonargs=(
		$(meson_use doc gtk_doc)
		$(meson_feature fftw)
		$(meson_feature imagemagick magick)
		$(meson_feature imagequant)
		$(meson_feature exif)
		$(meson_feature fits cfitsio)
		$(meson_feature heif)
		$(meson_feature jpeg)
		$(meson_feature gsf)
		$(meson_feature lcms)
		$(meson_feature openexr)
		$(meson_feature orc)
		$(meson_feature pango pangocairo)
		$(meson_feature pdf poppler)
		$(meson_feature png)
		$(meson_feature svg rsvg)
		$(meson_feature tiff)
		$(meson_feature webp)
		$(meson_feature zlib)
		$(meson_feature matio)
	)
	meson_src_configure
}
