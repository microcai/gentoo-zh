# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit rpm

RESTRICT="nomirror nostrip"

RPM_V=1.0

DESCRIPTION="Hong Kong SAR Government Official Reference Chinese Font that implements ISO10646 and HKSCS-2001"
HOMEPAGE="http://www.info.gov.hk/digital21/eng/hkscs/hkscs_iso.html"
SRC_URI="http://www.info.gov.hk/digital21/chi/hkscs/download/linux_redhat/setup.bin"

LICENSE="HKSCS"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND=""

S=${WORKDIR}

src_unpack() {
	# complicated and convoluted unpack procedure
	LINENUMBER=237
	cd ${S}; tail -n +${LINENUMBER} ${DISTDIR}/${A} | tar zxv || die "unpack failed"

	# then we rpm_unpack the fonts package
	rpm_unpack ${S}/package_rh/imfont-${RPM_V}-0.i386.rpm
}

src_compile() {
	return
}

src_install() {
	insinto /usr/share/fonts/ttf
	doins usr/share/inputmethod/ming_uni.ttf

	/usr/X11R6/bin/mkfontscale ${D}/usr/share/fonts/ttf
	/usr/X11R6/bin/mkfontdir ${D}/usr/share/fonts/ttf
}
