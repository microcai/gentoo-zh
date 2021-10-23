# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop pax-utils xdg

DESCRIPTION="A complete, free Microsoft Office-compatible alternative office suite"
HOMEPAGE="https://www.freeoffice.com"
BASE_URI="https://www.softmaker.net/down/softmaker-${P}"
SRC_URI="${BASE_URI}-amd64.tgz"

LICENSE="SoftMaker"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RESTRICT="mirror strip"

DEPEND="
	app-admin/chrpath
	app-arch/xz-utils"
RDEPEND="
	${DEPEND}
	media-libs/mesa
	net-misc/curl
	x11-libs/libXrandr"

QA_PRESTRIPPED="*"

S="${WORKDIR}"

src_unpack() {
	:
}

src_install(){
	mkdir -p "${ED%/}/usr/$(get_libdir)/${PN}"
	cd "${ED%/}/usr/$(get_libdir)/${PN}/"

	unpack ${A}
	xz -d "freeoffice2021.tar.lzma" || die
	tar x -f "freeoffice2021.tar" \
		&& rm "freeoffice2021.tar" || die
	rm "installfreeoffice"

	chrpath --delete "textmaker"
	chrpath --delete "planmaker"
	chrpath --delete "presentations"

	for m in "${FILESDIR}"/*.desktop; do
		domenu "${m}"
	done

	for e in planmaker presentations textmaker; do
		dobin "${FILESDIR}/freeoffice-${e}"
	done

	for size in 16 24 32 48 64 128 256 512; do
		newicon -s ${size} icons/pml_${size}.png ${PN}-planmaker.png
		newicon -s ${size} icons/prl_${size}.png ${PN}-presentations.png
		newicon -s ${size} icons/tml_${size}.png ${PN}-textmaker.png
	done

	insinto /usr/share/mime/packages
	doins mime/softmaker-freeoffice21.xml

	pax-mark -m "${ED%/}"/usr/$(get_libdir)/${PN}/planmaker
	pax-mark -m "${ED%/}"/usr/$(get_libdir)/${PN}/presentations
	pax-mark -m "${ED%/}"/usr/$(get_libdir)/${PN}/textmaker
}

pkg_postinst(){
	einfo
	elog "In order to use Softmaker Freeoffice, you need a serial number."
	elog "To obtain a valid free serial number, please visit"
	elog "https://www.freeoffice.com/en/download"
	einfo
	xdg_pkg_postinst
}
