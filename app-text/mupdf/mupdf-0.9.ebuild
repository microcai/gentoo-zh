# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/mupdf/mupdf-0.8.165.ebuild,v 1.4 2011/08/23 23:07:36 xmw Exp $

EAPI=2

inherit eutils multilib toolchain-funcs

DESCRIPTION="a lightweight PDF viewer and toolkit written in portable C"
HOMEPAGE="http://mupdf.com/"
SRC_URI="http://mupdf.com/download/${P}-source.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="X vanilla"

RDEPEND="media-libs/freetype:2
	media-libs/jbig2dec
	virtual/jpeg
	media-libs/openjpeg
	X? ( x11-libs/libX11
		x11-libs/libXext )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-buildsystem.patch

	use vanilla || epatch "${FILESDIR}"/${PN}-zoom.patch
}

src_compile() {
	local my_pdfexe=
	use X || my_nox11="NOX11=yes MUPDF= "

	emake CC="$(tc-getCC)" \
		build=debug verbose=true ${my_nox11} -j1 || die
}

src_install() {
	emake prefix="${D}usr" LIBDIR="${D}usr/$(get_libdir)" \
		build=debug verbose=true ${my_nox11} install || die

	insinto /usr/$(get_libdir)/pkgconfig
	doins debian/mupdf.pc || die

	if use X ; then
		domenu debian/mupdf.desktop || die
		doicon debian/mupdf.xpm || die
		doman apps/man/mupdf.1 || die
	fi
	doman apps/man/pdf{clean,draw,show}.1 || die
	dodoc README || die

	# avoid collision with app-text/poppler-utils
	mv "${D}"usr/bin/pdfinfo "${D}"usr/bin/mupdf_pdfinfo || die
}

pkg_postinst() {
	elog "pdfinfo was renamed to mupdf_pdfinfo"
}
