# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils flag-o-matic multilib toolchain-funcs

DESCRIPTION="a lightweight PDF viewer and toolkit written in portable C"
HOMEPAGE="http://mupdf.com/"
SRC_URI="http://${PN}.com/download/source/${P}-source.tar.gz
	http://xmw.de/mirror/${PN}/${P}-source.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X"

S=${WORKDIR}/${PN}

RDEPEND="media-libs/freetype:2
	media-libs/jbig2dec
	media-libs/jpeg
	media-libs/openjpeg
	X? ( x11-libs/libX11
		x11-libs/libXext )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-buildsystem.patch
}

src_compile() {
	use x86 && append-cflags -DARCH_X86
	use amd64 && append-cflags -DARCH_X86_64

	my_pdfexe=
	use X || my_pdfexe="PDFVIEW_EXE="

	emake build=release ${my_pdfexe} CC="$(tc-getCC)" || die
}

src_install() {
	emake build=release ${my_pdfexe} prefix="${D}usr" \
		libprefix="${D}usr/$(get_libdir)" install || die

	insinto /usr/$(get_libdir)/pkgconfig
	doins debian/mupdf.pc || die

	if use X ; then
		domenu debian/mupdf.desktop || die
		doicon debian/mupdf.xpm || die
		doman debian/mupdf.1 || die
	fi
	doman debian/pdf{clean,draw,show}.1 || die
	dodoc README || die

	# avoid collision with app-text/poppler-utils
	mv "${D}"usr/bin/pdfinfo "${D}"usr/bin/mupdf_pdfinfo || die
}

pkg_postinst() {
	elog "pdfinfo was renamed to mupdf_pdfinfo"
}
